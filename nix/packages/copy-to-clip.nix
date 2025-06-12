{
  writeTextFile,
  runtimeShell,
  wl-clipboard,
  cliphist,
  ...
}:
writeTextFile {
  name = "copy-to-clip";
  text = ''
    #! ${runtimeShell}
    ${./../../scripts/copy-to-clip.sh}
  '';
  destination = "/bin/copy-to-clip.sh";
  executable = true;
  derivationArgs = {nativeBuildInputs = [cliphist wl-clipboard];};
}
