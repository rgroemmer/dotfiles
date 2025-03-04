{
  imports = [
    # system
    ./system/boot.nix
    ./system/env.nix
    ./system/user.nix
    ./system/locale.nix

    # services
    ./services/sound.nix
    ./services/bluetooth.nix
    ./services/printer.nix
    ./services/opengl.nix
    ./services/nh.nix
    ./services/podman.nix

    # security
    ./security/sops.nix

    # modules
    ./modules/k3s
    ./modules/desktop
    ./modules/gaming

    # global nix config
    ../nix.nix
  ];

  nix.optimise.automatic = true;
  system.stateVersion = "24.11";
}
