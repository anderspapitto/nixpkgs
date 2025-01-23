{
  stdenvNoCC,
  lib,
  fetchurl,
  curl,
  common-updater-scripts,
  writeShellApplication,
  gnugrep,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "tideways-daemon";
  version = "1.9.32";

  src =
    finalAttrs.passthru.sources.${stdenvNoCC.hostPlatform.system}
      or (throw "Unsupported platform for tideways-cli: ${stdenvNoCC.hostPlatform.system}");

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp tideways-daemon $out/bin/tideways-daemon
    chmod +x $out/bin/tideways-daemon
    runHook postInstall
  '';

  passthru = {
    sources = {
      "x86_64-linux" = fetchurl {
        url = "https://tideways.s3.amazonaws.com/daemon/${finalAttrs.version}/tideways-daemon_linux_amd64-${finalAttrs.version}.tar.gz";
        hash = "sha256-d7qC6q6ukr2bPEEbgFa8u2N+u/cn0CvWXlrO4CAthl8=";
      };
      "aarch64-linux" = fetchurl {
        url = "https://tideways.s3.amazonaws.com/daemon/${finalAttrs.version}/tideways-daemon_linux_aarch64-${finalAttrs.version}.tar.gz";
        hash = "sha256-3HXmX2mjM6buzMiVsmTSxReJ7ulphxzSL9hSR6Jwocg=";
      };
      "aarch64-darwin" = fetchurl {
        url = "https://tideways.s3.amazonaws.com/daemon/${finalAttrs.version}/tideways-daemon_macos_arm64-${finalAttrs.version}.tar.gz";
        hash = "sha256-3oWU1OjefWGOUmHsAgHIKlUqHiGWbty3WPex7wTfLIg=";
      };
    };
    updateScript = "${
      writeShellApplication {
        name = "update-tideways-daemon";
        runtimeInputs = [
          curl
          gnugrep
          common-updater-scripts
        ];
        text = ''
          NEW_VERSION=$(curl --fail -L -s https://tideways.com/profiler/downloads | grep -E 'https://tideways.s3.amazonaws.com/daemon/([0-9]+\.[0-9]+\.[0-9]+)/tideways-daemon_linux_amd64-\1.tar.gz' | grep -oP 'daemon/\K[0-9]+\.[0-9]+\.[0-9]+')

          if [[ "${finalAttrs.version}" = "$NEW_VERSION" ]]; then
              echo "The new version same as the old version."
              exit 0
          fi

          for platform in ${lib.escapeShellArgs finalAttrs.meta.platforms}; do
            update-source-version "tideways-daemon" "$NEW_VERSION" --ignore-same-version --source-key="sources.$platform"
          done
        '';
      }
    }/bin/update-tideways-daemon";
  };

  meta = with lib; {
    description = "Tideways Daemon";
    homepage = "https://tideways.com/";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    mainProgram = "tideways-daemon";
    license = licenses.unfree;
    maintainers = with maintainers; [ shyim ];
    platforms = lib.attrNames finalAttrs.passthru.sources;
  };
})
