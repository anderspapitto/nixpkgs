#!/usr/bin/env nix-shell
#!nix-shell update-shell.nix -i python3

# format:
# $ nix run nixpkgs#python3Packages.ruff -- update.py
# type-check:
# $ nix run nixpkgs#python3Packages.mypy -- update.py
# linted:
# $ nix run nixpkgs#python3Packages.flake8 -- --ignore E501,E265,E402 update.py

import inspect
import os
import sys
from pathlib import Path
from typing import List, Tuple

# Import plugin update library from maintainers/scripts/pluginupdate.py
ROOT = Path(os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe()))))  # type: ignore
sys.path.insert(
    0, os.path.join(ROOT.parent.parent.parent.parent.parent, "maintainers", "scripts")
)
import pluginupdate

GET_PLUGINS = f"""(
with import <localpkgs> {{ }};
let
  inherit (kakouneUtils.override {{ }}) buildKakounePluginFrom2Nix;
  generated = callPackage {ROOT}/generated.nix {{
    inherit buildKakounePluginFrom2Nix;
  }};
  hasChecksum =
    value:
    lib.isAttrs value
    && lib.hasAttrByPath [
      "src"
      "outputHash"
    ] value;
  getChecksum =
    name: value:
    if hasChecksum value then
      {{
        submodules = value.src.fetchSubmodules or false;
        sha256 = value.src.outputHash;
        rev = value.src.rev;
      }}
    else
      null;
  checksums = lib.mapAttrs getChecksum generated;
in
lib.filterAttrs (n: v: v != null) checksums
)"""

HEADER = "# This file has been generated by ./pkgs/applications/editors/kakoune/plugins/update.py. Do not edit!"


class KakouneEditor(pluginupdate.Editor):
    def generate_nix(
        self,
        plugins: List[Tuple[pluginupdate.PluginDesc, pluginupdate.Plugin]],
        outfile: str,
    ):
        sorted_plugins = sorted(plugins, key=lambda v: v[1].name.lower())

        with open(outfile, "w+") as f:
            f.write(HEADER)
            f.write(
                """
{ lib, buildKakounePluginFrom2Nix, fetchFromGitHub, overrides ? (self: super: {}) }:
let
packages = ( self:
{"""
            )
            for pluginDesc, plugin in sorted_plugins:
                f.write(
                    f"""
  {plugin.normalized_name} = buildKakounePluginFrom2Nix {{
    pname = "{plugin.normalized_name}";
    version = "{plugin.version}";
    src = {pluginDesc.repo.as_nix(plugin)};
    meta.homepage = "{pluginDesc.repo.url("")}";
  }};
"""
                )
            f.write(
                """
});
in lib.fix' (lib.extends overrides packages)
"""
            )
        print(f"updated {outfile}")

    def update(self, args):
        pluginupdate.update_plugins(self, args)


def main():
    editor = KakouneEditor("kakoune", ROOT, GET_PLUGINS)
    editor.run()


if __name__ == "__main__":
    main()
