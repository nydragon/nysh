{
  lib,
  inputs,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) package;
  cfg = config.modules.services.nysh;
in {
  options.modules.services.nysh = {
    enable = mkEnableOption "nysh";
    package = mkOption {
      type = package;
      default = inputs.nysh.packages.${pkgs.system}.nysh;
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.nysh = {
      path = with pkgs; [
        bashNonInteractive
      ];
      wantedBy = ["graphical-session.target"];
      after = ["graphical-session.target"];

      script = ''
        /bin/sh -lc ${cfg.package}/bin/nysh -v
      '';

      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        NoNewPrivileges = true;
        ReadWritePaths = "/tmp";
      };
    };
  };
}
