{
  lib,
  inputs,
  ...
}: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"

    ./installer.nix
    ../../nixos
  ];

  # Host specific configuration
  system = {
    boot = {
      systemd = true;
      supportedFilesystems = ["ntfs"];
    };
    user = {
      name = "root";
      initialHashedPassword = "";
      extraOptions = {};
      extraGroups = [];
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqKYXW07z0llbDKRIakLD1PjHe3HxK9iu6czXs+ZU7v";
    };
    services = {};
  };

  networking.hostName = "rapsn-iso-nix-installer";
  zramSwap.enable = true; # save RAM for VMs & small hosts

  services = {
    getty.autologinUser = lib.mkForce "root";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
