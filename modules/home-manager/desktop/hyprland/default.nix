{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.roles.desktop.hyprland;
in {
  imports = [
    # Config
    ./config

    # Addons
    ./addons/hyprpaper.nix
    ./addons/hyprlock.nix
  ];

  options.roles.desktop.hyprland = {
    enable = mkEnableOption "Enable hyprland";
    hyprlock = mkEnableOption "Enable hyprlock & hypridle";
    hyprpaper = mkEnableOption "Enable hyprpaper desktop wallpaper manager";
    configOnly = mkEnableOption "Only write hyprland config with home-manager";
    monitors = mkOption {
      type = with types; listOf attrs;
      default = [];
    };
  };

  config = mkIf cfg.enable {
    catppuccin.hyprland.enable = true;

    wayland.windowManager.hyprland = mkMerge [
      {enable = true;}

      (mkIf cfg.configOnly {
        package = null;
        systemd.enable = false;
        xwayland.enable = false;
        portalPackage = null;
      })
    ];

    home.packages = with pkgs;
      mkIf (!cfg.configOnly) [
        hyprland-qtutils
      ];

    xdg.portal = {
      enable = !cfg.configOnly;
      config = {
        common = {
          default = ["hyprland" "gtk"];
        };
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };

    # Make nix-path available for all tools
    xdg.configFile."environment.d/envvars.conf".text = ''
      PATH="$HOME/.nix-profile/bin:$PATH"
    '';
  };
}
