{ inputs, pkgs, ... }: {
  imports = [
    ./config

    ./waybar
    ./wlogout
    ./swaync
    ./swaylock.nix
    ./theme

    inputs.hyprland-nix.homeManagerModules.default
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland;xcb";
    LIBSEAT_BACKEND = "logind";
  };

  home.packages = with pkgs; [
    xdg-utils
    wl-clipboard # pbcopy like
    pamixer

    # screenshot
    grimblast
    slurp
    sway-contrib.grimshot
    #TODO: check out
    pkgs.xdg-desktop-portal-hyprland
  ];

  nix.settings = {
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys =
      [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
}
