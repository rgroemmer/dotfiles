{pkgs, ...}: {
  imports = [
    # Config
    ./config

    # Addons
    ./addons/hyprpaper.nix
    ./addons/hyprlock.nix
  ];

  home.packages = with pkgs; [
    hyprland-qtutils
  ];

  # catppuccin.hyprland.enable = true;
  xdg.configFile."environment.d/envvars.conf".text = ''
    PATH="$HOME/.nix-profile/bin:$PATH"
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    systemd.enable = true;
    xwayland.enable = true;
  };
}
