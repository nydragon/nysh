{ pkgs, quickshell, ... }:
pkgs.mkShell {
  packages = [
    quickshell
    pkgs.kdePackages.qtdeclarative
    pkgs.pre-commit
    pkgs.typos

  ];
  shellHook = ''
    # Required for qmlls to find the correct type declarations
    # Sadly Quickshell doesn't export some types declaratively
    export QMLLS_BUILD_DIRS=${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml/:${quickshell}/lib/qt-6/qml/
    export QML_IMPORT_PATH=$PWD/src
    ${pkgs.pre-commit}/bin/pre-commit install -f
  '';
}
