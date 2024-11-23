{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ../../nixos/common
    ./installer.nix

    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = lib.mkForce [
      "vfat"
      "ntfs"
    ];
  };

  networking.hostName = "rapsn-iso-nix-installer";

  # try to save RAM
  zramSwap.enable = true;

  services = {
    openssh.enable = true;
    getty.autologinUser = lib.mkForce "root";
  };

  users.users.root = {
    hashedPassword = "$y$j9T$EMO/EfdbflSVB//fPjqSi/$3jrcxQr/AEXtJZSXtc0ISAZbnqum.TW9vIi8bgMA2F1";
    initialHashedPassword = lib.mkForce null;
    initialPassword = lib.mkForce null;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqKYXW07z0llbDKRIakLD1PjHe3HxK9iu6czXs+ZU7v iso@rapsn"
    ];
  };

  system.stateVersion = "24.11";
}
