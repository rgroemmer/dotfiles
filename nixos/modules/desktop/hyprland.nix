{
  lib,
  config,
  ...
}: let
  cfg = config.system.modules.desktop;
in
  with lib; {
    config = mkIf cfg {
      programs.hyprland.enable = true;

      services.greetd = {
        enable = true;
        settings = rec {
          initial_session = {
            command = "Hyprland";
            user = "rap";
          };
          default_session = initial_session;
        };
      };

      environment.etc."greetd/environments".text = ''
        Hyprland
      '';
    };
  }
