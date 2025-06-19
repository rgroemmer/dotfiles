{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.system.modules.desktop;
in {
  config = mkIf cfg {
    programs.hyprland.enable = true;

    services.greetd = {
      enable = true;
      settings = {
        terminal.vt = 7;
        default_session = {
          command = "Hyprland --config /etc/greetd/hyprland.conf";
          user = "greeter";
        };
      };
    };

    environment.etc."greetd/hyprland.conf".text = ''
      exec-once = ${pkgs.greetd.qtgreet}/bin/qtgreet; hyprctl dispatch exit
    '';
  };
}
