{
  imports = [
    # system
    ./system/boot.nix
    ./system/env.nix
    ./system/user.nix
    ./system/locale.nix
    ./system/packages.nix
    ./system/auto-upgrade.nix

    # services
    ./services/sound.nix
    ./services/bluetooth.nix
    ./services/printer.nix
    ./services/opengl.nix

    # security
    ./security/sops.nix

    # modules
    ./modules/k3s
    ./modules/desktop
  ];

  system.stateVersion = "24.11";
}
