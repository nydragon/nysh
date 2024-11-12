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
    cp ${quickshell}/bin/quickshell $out/bin/nysh

    wrapProgram $out/bin/nysh \
       --add-flags "-p ${./..}/src"
  '';
}
