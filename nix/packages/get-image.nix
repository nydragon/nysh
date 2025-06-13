{
  lib,
  writers,
  cliphist,
  ...
}:
writers.writeBashBin
"get-image.sh"
{
  makeWrapperArgs = [
    "--prefix"
    "PATH"
    ":"
    "${lib.makeBinPath [cliphist]}"
  ];
}
(builtins.readFile ./../../scripts/get-image.sh)
