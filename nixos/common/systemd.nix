{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.base.systemd;
in
  with lib; {
    options.base.systemd = {
      enable = mkEnableOption "systemd";
    };

    config = mkIf cfg.enable {
    };
  }
