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
    {
      nixpkgs,
      utils,
      quickshell,
      ...
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            quickshell.packages.${system}.default
            pkgs.kdePackages.qtdeclarative
          ];
        };
        defaultPackage = import ./nix/package.nix {
          inherit (pkgs) stdenv;
          quickshell = quickshell.packages.${system}.default;
        };
      }
    );
}
