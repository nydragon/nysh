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
./../../scripts/get-image.sh
