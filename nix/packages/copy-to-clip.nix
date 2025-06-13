{
  lib,
  writers,
  wl-clipboard,
  cliphist,
  ...
}:
writers.writeBashBin
"copy-to-clip.sh"
{
  makeWrapperArgs = [
    "--prefix"
    "PATH"
    ":"
    "${lib.makeBinPath [cliphist wl-clipboard]}"
  ];
}
./../../scripts/copy-to-clip.sh
