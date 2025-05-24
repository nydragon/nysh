{
  stdenv,
  quickshell,
  makeWrapper,
  writeShellScriptBin,
  ...
}: let
  get-image = writeShellScriptBin "get-image" ./../scripts/get-image.sh;
in
  stdenv.mkDerivation {
    name = "nysh";

    unpackPhase = ":";

    nativeBuildInputs = [makeWrapper get-image];

    installPhase = ''
      mkdir -p $out/bin
      cp ${quickshell}/bin/quickshell $out/bin/nysh

      wrapProgram $out/bin/nysh \
         --add-flags "-p ${./..}/src"
    '';
  }
