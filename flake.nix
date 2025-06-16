{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    quickshell = {
      url = "git+https://github.com/quickshell-mirror/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    supportedSystems = ["x86_64-linux"];

    forAllSystems = function:
      nixpkgs.lib.genAttrs
      supportedSystems
      (system: function nixpkgs.legacyPackages.${system});
  in {
    packages = forAllSystems (pkgs: {
      default = self.packages.${pkgs.system}.nysh;
      nysh = pkgs.callPackage ./nix/packages/nysh.nix {
        inherit (inputs.quickshell.packages.${pkgs.system}) quickshell;
        inherit (self.packages.${pkgs.system}) copy-to-clip get-image screenshot;
      };

      copy-to-clip = pkgs.callPackage ./nix/packages/copy-to-clip.nix {};
      get-image = pkgs.callPackage ./nix/packages/get-image.nix {};
      screenshot = pkgs.callPackage ./nix/packages/screenshot.nix {};
    });

    devShells = forAllSystems (pkgs: {
      default = pkgs.callPackage ./nix/shell.nix {
        inherit (inputs.quickshell.packages.${pkgs.system}) quickshell;
        inherit (self.packages.${pkgs.system}) get-image copy-to-clip screenshot;
      };
    });

    nixosModules = {
      nysh = import ./nix/module.nix;
      default = self.nixosModules.nysh;
    };
  };
}
