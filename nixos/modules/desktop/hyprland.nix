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

    catppuccin.sddm = {
      enable = true;
    };
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
    };
  };
}
