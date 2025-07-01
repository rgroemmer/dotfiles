{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.system.roles.desktop;
in {
  options.system.roles.desktop = mkEnableOption "Enable hyprland and desktop features.";

  config = mkIf cfg {
    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
        ];
      };
    };

    services = {
      gvfs.enable = true; # virtual filesystems
      udisks2.enable = true; # automounts
    };
  };
}
