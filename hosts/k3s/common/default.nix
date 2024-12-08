{
  imports = [
    ../../../nixos

    ./hardware-configuration.nix
    ./disko.nix
  ];

  nix.settings.trusted-users = ["@wheel"]; # need for remote build
}
