{
  lib,
  stdenv,
  quickshell,
  makeWrapper,
  coreutils,
  grim,
  cliphist,
  get-image,
  copy-to-clip,
  screenshot,
  ...
}:
stdenv.mkDerivation {
  name = "nysh";

  unpackPhase = ":";

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    mkdir -p $out/bin
    cp ${quickshell}/bin/quickshell $out/bin/nysh

    wrapProgram $out/bin/nysh \
       --add-flags "-p ${./../..}/src" \
       --prefix PATH : "${lib.makeBinPath [coreutils get-image copy-to-clip screenshot grim cliphist]}"
  '';
}
