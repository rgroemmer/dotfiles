{pkgs, ...}: {
  imports = [
    ./config.nix
    ./keybindings.nix
    ./hyprpaper.nix
    ./hyprlock.nix
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
