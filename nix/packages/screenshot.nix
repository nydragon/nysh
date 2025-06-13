{
  lib,
  writers,
  wl-clipboard,
  grim,
  libnotify,
  ...
}:
writers.writeBashBin
"screenshot.sh"
{
  makeWrapperArgs = [
    "--prefix"
    "PATH"
    ":"
    "${lib.makeBinPath [grim wl-clipboard libnotify]}"
  ];
}
(builtins.readFile ./../../scripts/screenshot.sh)
