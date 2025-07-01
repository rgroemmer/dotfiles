{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.roles.desktop;

  configOnly = {
    package = null;
    systemd.enable = false;
    xwayland.enable = false;
  };
in {
  imports = [
    # Config
    ./config

    # Addons
    ./addons/hyprpaper.nix
    ./addons/hyprlock.nix
  ];

  options.roles.desktop.hyprland = {
    hyprlock = mkEnableOption "Enable hyprlock & hypridle";
    hyprpaper = mkEnableOption "Enable hyprpaper desktop wallpaper manager";
    configOnly = mkEnableOption "Only write hyprland config with home-manager";
  };

  config = {
    # TODO: Make this conditional?
    home.packages = with pkgs; [
      hyprland-qtutils
    ];

    # TODO: Make this conditional, when portals installed via PPA
    xdg.portal = {
      enable = true;
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

    catppuccin.hyprland.enable = true;
    wayland.windowManager.hyprland =
      {
        enable = true;
        package =
          if cfg.hyprland.configOnly
          then null
          else pkgs.hyprland;
        systemd.enable = true;
        xwayland.enable = true;
      }
      // mkIf cfg.hyprland.configOnly configOnly;

    # Make nix-path available for all tools
    xdg.configFile."environment.d/envvars.conf".text = ''
      PATH="$HOME/.nix-profile/bin:$PATH"
    '';
  };
}
