{pkgs, ...}: {
  imports = [
    ./config.nix
    ./keybindings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    catppuccin.enable = true;

    package = pkgs.hyprland;
    systemd.enable = true;
    xwayland.enable = true;
  };
}
