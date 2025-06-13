{
  lib,
  writers,
  wl-clipboard,
  grim,
  ...
}:
writers.writeBash
"screenshot.sh"
{
  makeWrapperArgs = [
    "--prefix"
    "PATH"
    ":"
    "${lib.makeBinPath [grim wl-clipboard]}"
  ];
}
./../../scripts/screenshot.sh
