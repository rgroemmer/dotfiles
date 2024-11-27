{
  imports = [
    # system
    ./system/boot.nix
    #./system/env.nix
    ./system/user.nix
    ./system/locale.nix
    ./system/packages.nix

    # hardware
    ./hardware/opengl.nix
    ./hardware/bluetooth.nix

    # services
    ./services/printer.nix
    ./services/sound.nix
    ./services/sops.nix

    # desktop
    ./desktop/explorer.nix
    ./desktop/fonts.nix
    ./desktop/power.nix
    ./desktop/hyprland.nix

    # modules
    ./modules/k3s
  ];

  system.stateVersion = "24.11";
}
