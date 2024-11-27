{
  lib,
  config,
  ...
}: let
  cfg = config.system.modules.desktop;
in
  with lib; {
    config = mkIf cfg {
      powerManagement.enable = false;
      systemd.targets = {
        sleep.enable = false;
        suspend.enable = false;
        hibernate.enable = false;
      };
    };
  }
