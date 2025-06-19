{pkgs, ...}: {
  imports = [
    # Config
    ./config/config.nix
    ./config/keybindings.nix

    # Addons
    ./addons/hyprpaper.nix
    ./addons/hyprlock.nix
  ];

  home.packages = with pkgs; [
    hyprland-qtutils
  ];

  catppuccin.hyprland.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;

    package = pkgs.hyprland;
    systemd.enable = true;
    xwayland.enable = true;
  };
}
