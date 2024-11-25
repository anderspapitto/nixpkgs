import argparse
import atexit
import json
import os
import sys
from pathlib import Path
from subprocess import run
from tempfile import TemporaryDirectory
from typing import assert_never

from .models import Action, Flake, NRError, Profile
from .nix import (
    copy_closure,
    edit,
    find_file,
    get_nixpkgs_rev,
    list_generations,
    nixos_build,
    nixos_build_flake,
    rollback,
    rollback_temporary_profile,
    set_profile,
    switch_to_configuration,
    upgrade_channels,
)
from .process import Remote, cleanup_ssh
from .utils import flags_to_dict, info

VERBOSE = 0


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        prog="nixos-rebuild",
        description="Reconfigure a NixOS machine",
        add_help=False,
        allow_abbrev=False,
    )
    parser.add_argument("--help", "-h", action="store_true")
    parser.add_argument("--file", "-f")
    parser.add_argument("--attr", "-A")
    parser.add_argument("--flake", nargs="?", const=True)
    parser.add_argument("--no-flake", dest="flake", action="store_false")
    parser.add_argument("--install-bootloader", action="store_true")
    parser.add_argument("--install-grub", action="store_true")  # deprecated
    parser.add_argument("--profile-name", "-p", default="system")
    parser.add_argument("--specialisation", "-c")
    parser.add_argument("--rollback", action="store_true")
    parser.add_argument("--upgrade", action="store_true")
    parser.add_argument("--upgrade-all", action="store_true")
    parser.add_argument("--json", action="store_true")
    parser.add_argument("--sudo", action="store_true")
    parser.add_argument("--use-remote-sudo", action="store_true")  # deprecated
    parser.add_argument("--no-ssh-tty", action="store_true")
    # parser.add_argument("--build-host")  # TODO
    parser.add_argument("--target-host")
    parser.add_argument("--verbose", "-v", action="count", default=0)
    parser.add_argument("action", choices=Action.values(), nargs="?")

    common_group = parser.add_argument_group("nix flags")
    common_group.add_argument("--include", "-I")
    common_group.add_argument("--max-jobs", "-j")
    common_group.add_argument("--cores")
    common_group.add_argument("--log-format")
    common_group.add_argument("--quiet", action="store_true")
    common_group.add_argument("--print-build-logs", "-L", action="store_true")
    common_group.add_argument("--show-trace", action="store_true")
    common_group.add_argument("--keep-going", "-k", action="store_true")
    common_group.add_argument("--keep-failed", "-K", action="store_true")
    common_group.add_argument("--fallback", action="store_true")
    common_group.add_argument("--repair", action="store_true")
    common_group.add_argument("--option", nargs=2)

    nix_group = parser.add_argument_group("nix classic flags")
    nix_group.add_argument("--no-build-output", "-Q", action="store_true")

    flake_group = parser.add_argument_group("nix flakes flags")
    flake_group.add_argument("--accept-flake-config", action="store_true")
    flake_group.add_argument("--refresh", action="store_true")
    flake_group.add_argument("--impure", action="store_true")
    flake_group.add_argument("--offline", action="store_true")
    flake_group.add_argument("--no-net", action="store_true")
    flake_group.add_argument("--recreate-lock-file", action="store_true")
    flake_group.add_argument("--no-update-lock-file", action="store_true")
    flake_group.add_argument("--no-write-lock-file", action="store_true")
    flake_group.add_argument("--no-registries", action="store_true")
    flake_group.add_argument("--commit-lock-file", action="store_true")
    flake_group.add_argument("--update-input")
    flake_group.add_argument("--override-input", nargs=2)

    copy_group = parser.add_argument_group("nix-copy-closure flags")
    copy_group.add_argument("--use-substitutes", "-s", action="store_true")

    args = parser.parse_args(argv[1:])

    global VERBOSE
    # This flag affects both nix and this script
    VERBOSE = args.verbose

    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/linux/nixos-rebuild/nixos-rebuild.sh#L56
    if args.action == Action.DRY_RUN.value:
        args.action = Action.DRY_BUILD.value

    # TODO: use deprecated=True in Python >=3.13
    if args.install_grub:
        info(
            f"{parser.prog}: warning: --install-grub deprecated, use --install-bootloader instead"
        )
        args.install_bootloader = True

    # TODO: use deprecated=True in Python >=3.13
    if args.use_remote_sudo:
        info(
            f"{parser.prog}: warning: --use-remote-sudo deprecated, use --sudo instead"
        )
        args.sudo = True

    if args.action == Action.EDIT.value and (args.file or args.attr):
        parser.error("--file and --attr are not supported with 'edit'")

    if args.flake and (args.file or args.attr):
        parser.error("--flake cannot be used with --file or --attr")

    if args.help or args.action is None:
        r = run(["man", "8", "nixos-rebuild"], check=False)
        parser.exit(r.returncode)

    return args


def execute(argv: list[str]) -> None:
    args = parse_args(argv)

    common_flags = flags_to_dict(
        args,
        [
            "max_jobs",
            "cores",
            "log_format",
            "keep_going",
            "keep_failed",
            "fallback",
            "repair",
            "verbose",
            "option",
        ],
    )
    common_build_flags = common_flags | flags_to_dict(
        args,
        [
            "include",
            "quiet",
            "print_build_logs",
            "show_trace",
        ],
    )
    build_flags = common_build_flags | flags_to_dict(args, ["no_build_output"])
    flake_build_flags = common_build_flags | flags_to_dict(
        args,
        [
            "accept_flake_config",
            "refresh",
            "impure",
            "offline",
            "no_net",
            "recreate_lock_file",
            "no_update_lock_file",
            "no_write_lock_file",
            "no_registries",
            "commit_lock_file",
            "update_input",
            "override_input",
        ],
    )
    copy_flags = common_flags | flags_to_dict(args, ["use_substitutes"])

    # Will be cleaned up on exit automatically.
    tmpdir = TemporaryDirectory(prefix="nixos-rebuild.")
    tmpdir_path = Path(tmpdir.name)
    atexit.register(cleanup_ssh, tmpdir_path)

    profile = Profile.from_name(args.profile_name)
    target_host = Remote.from_arg(args.target_host, not args.no_ssh_tty, tmpdir_path)
    flake = Flake.from_arg(args.flake, target_host)

    if args.upgrade or args.upgrade_all:
        upgrade_channels(bool(args.upgrade_all))

    action = Action(args.action)
    # Only run shell scripts from the Nixpkgs tree if the action is
    # "switch", "boot", or "test". With other actions (such as "build"),
    # the user may reasonably expect that no code from the Nixpkgs tree is
    # executed, so it's safe to run nixos-rebuild against a potentially
    # untrusted tree.
    can_run = action in (Action.SWITCH, Action.BOOT, Action.TEST)
    if can_run and not flake:
        nixpkgs_path = find_file("nixpkgs", **build_flags)
        rev = get_nixpkgs_rev(nixpkgs_path)
        if nixpkgs_path and rev:
            (nixpkgs_path / ".version-suffix").write_text(rev)

    match action:
        case Action.SWITCH | Action.BOOT:
            info("building the system configuration...")
            if args.rollback:
                path_to_config = rollback(profile)
            else:
                if flake:
                    path_to_config = nixos_build_flake(
                        "toplevel",
                        flake,
                        no_link=True,
                        **flake_build_flags,
                    )
                else:
                    path_to_config = nixos_build(
                        "system",
                        args.attr,
                        args.file,
                        no_out_link=True,
                        **build_flags,
                    )
                copy_closure(path_to_config, target_host, **copy_flags)
                set_profile(profile, path_to_config, target_host, sudo=args.sudo)
            switch_to_configuration(
                path_to_config,
                action,
                target_host,
                sudo=args.sudo,
                specialisation=args.specialisation,
                install_bootloader=args.install_bootloader,
            )
        case Action.TEST | Action.BUILD | Action.DRY_BUILD | Action.DRY_ACTIVATE:
            info("building the system configuration...")
            dry_run = action == Action.DRY_BUILD
            if args.rollback:
                if action not in (Action.TEST, Action.BUILD):
                    raise NRError(f"--rollback is incompatible with '{action}'")
                maybe_path_to_config = rollback_temporary_profile(profile)
                if maybe_path_to_config:  # kinda silly but this makes mypy happy
                    path_to_config = maybe_path_to_config
                else:
                    raise NRError("could not find previous generation")
            elif flake:
                path_to_config = nixos_build_flake(
                    "toplevel",
                    flake,
                    keep_going=True,
                    dry_run=dry_run,
                    **flake_build_flags,
                )
            else:
                path_to_config = nixos_build(
                    "system",
                    args.attr,
                    args.file,
                    keep_going=True,
                    dry_run=dry_run,
                    **build_flags,
                )
            if action in (Action.TEST, Action.DRY_ACTIVATE):
                switch_to_configuration(
                    path_to_config,
                    action,
                    target_host,
                    sudo=args.sudo,
                    specialisation=args.specialisation,
                )
        case Action.BUILD_VM | Action.BUILD_VM_WITH_BOOTLOADER:
            info("building the system configuration...")
            attr = "vm" if action == Action.BUILD_VM else "vmWithBootLoader"
            if flake:
                path_to_config = nixos_build_flake(
                    attr,
                    flake,
                    keep_going=True,
                    **flake_build_flags,
                )
            else:
                path_to_config = nixos_build(
                    attr,
                    args.attr,
                    args.file,
                    keep_going=True,
                    **build_flags,
                )
            vm_path = next(path_to_config.glob("bin/run-*-vm"), "./result/bin/run-*-vm")
            print(f"Done. The virtual machine can be started by running '{vm_path}'")
        case Action.EDIT:
            edit(flake, **flake_build_flags)
        case Action.DRY_RUN:
            assert False, "DRY_RUN should be a DRY_BUILD alias"
        case Action.LIST_GENERATIONS:
            generations = list_generations(profile)
            if args.json:
                print(json.dumps(generations, indent=2))
            else:
                from tabulate import tabulate

                headers = {
                    "generation": "Generation",
                    "date": "Build-date",
                    "nixosVersion": "NixOS version",
                    "kernelVersion": "Kernel",
                    "configurationRevision": "Configuration Revision",
                    "specialisations": "Specialisation",
                    "current": "Current",
                }
                # Not exactly the same format as legacy nixos-rebuild but close
                # enough
                table = tabulate(
                    generations,
                    headers=headers,
                    tablefmt="plain",
                    numalign="left",
                    stralign="left",
                    disable_numparse=True,
                )
                print(table)
        case Action.REPL:
            # For now just redirect it to `nixos-rebuild` instead of
            # duplicating the code
            os.execv(
                "@nixos_rebuild@",
                argv,
            )
        case _:
            assert_never(action)


def main() -> None:
    try:
        execute(sys.argv)
    except (Exception, KeyboardInterrupt) as ex:
        if VERBOSE:
            raise ex
        else:
            sys.exit(str(ex))
