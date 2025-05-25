{
  lib,
  stdenv,
  quickshell,
  makeWrapper,
  writeShellScriptBin,
  coreutils,
  ...
}: let
  get-image = writeShellScriptBin "get-image.sh" ./../scripts/get-image.sh;
  copy-to-clip = writeShellScriptBin "copy-to-clip.sh" ./../scripts/ccopy-to-clip.sh;
in
  stdenv.mkDerivation {
    name = "nysh";

    unpackPhase = ":";

    nativeBuildInputs = [makeWrapper];
    buildInputs = [get-image];
    installPhase = ''
      mkdir -p $out/bin
      cp ${quickshell}/bin/quickshell $out/bin/nysh

      wrapProgram $out/bin/nysh \
         --add-flags "-p ${./..}/src" \
         --prefix PATH : "${lib.makeBinPath [coreutils get-image copy-to-clip]}"
    '';
  }
