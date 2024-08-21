{ stdenv, quickshell, ... }:
stdenv.mkDerivation rec {
  name = "nysh";

  unpackPhase = ":";

  buildPhase = ''
    cat > ${name} <<EOF
    #! $SHELL
    ${quickshell}/bin/quickshell -p ${../src}
    EOF
    chmod +x ${name}
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ${name} $out/bin/
  '';
}
