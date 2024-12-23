{
  lib,
  runCommand,
  zig,
  stdenv,
  makeWrapper,
}:
let
  targetPrefix = lib.optionalString (
    stdenv.hostPlatform != stdenv.targetPlatform
  ) "${stdenv.targetPlatform.config}-";
in
runCommand "zig-cc-${zig.version}"
  {
    pname = "zig-cc";
    inherit (zig) version meta;

    nativeBuildInputs = [ makeWrapper ];

    passthru = {
      isZig = true;
      inherit targetPrefix;
    };

    inherit zig;
  }
  ''
    mkdir -p $out/bin
    for tool in cc c++ ld.lld; do
      makeWrapper "$zig/bin/zig" "$out/bin/${targetPrefix}$tool" \
        --add-flags "$tool" \
        --run "export ZIG_GLOBAL_CACHE_DIR=\$(mktemp -d)"
    done

    mv $out/bin/${targetPrefix}c++ $out/bin/${targetPrefix}clang++
    mv $out/bin/${targetPrefix}cc $out/bin/${targetPrefix}clang
    mv $out/bin/${targetPrefix}ld.lld $out/bin/${targetPrefix}ld
  ''
