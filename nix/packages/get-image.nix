{
  writeTextFile,
  runtimeShell,
  cliphist,
  ...
}:
writeTextFile {
  name = "get-image";
  text = ''
    #! ${runtimeShell}
    ${./../../scripts/get-image.sh}
  '';
  destination = "/bin/get-image.sh";
  executable = true;
  derivationArgs = {nativeBuildInputs = [cliphist];};
}
