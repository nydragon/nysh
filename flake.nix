{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    utils.url = "github:numtide/flake-utils";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, utils, ... }@inputs:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        quickshell = inputs.quickshell.packages.${system}.default.override { withQMLLib = true; };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            quickshell
            pkgs.kdePackages.qtdeclarative
          ];
        };
        defaultPackage = import ./nix/package.nix {
          inherit (pkgs) stdenv;
          inherit quickshell;
        };
      }
    );
}
