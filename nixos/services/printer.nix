{
  lib,
  config,
  ...
}: let
  cfg = config.system.services.printing;
in
  with lib; {
    options.system.services.printing = mkEnableOption "Enable printing service.";

    config = mkIf cfg {
      services = {
        printing.enable = true;

        avahi = {
          enable = true;
          nssmdns4 = true;

          openFirewall = true;
        };
      };
    };
  }
