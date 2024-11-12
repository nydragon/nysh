{
  stdenv,
  quickshell,
  makeWrapper,
  ...
}:
stdenv.mkDerivation {
  name = "nysh";

  unpackPhase = ":";

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${quickshell}/bin/quickshell $out/bin

    wrapProgram $out/bin/quickshell \
       --add-flags "-p ${./..}/src"
  '';
}
