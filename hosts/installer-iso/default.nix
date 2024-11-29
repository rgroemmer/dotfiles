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
      extraGroups = [];
      extraOptions = {
        hashedPassword = "$y$j9T$EBF4XbDjYpcGfgk0M5iNU0$XBaBsfh93W0iA2L.XtNBUi8BRfWsd9NMNzL99FNs4y/";
      };
    };
    services = {};
    modules = {
      k3s.enable = true;
    };
  };

  networking.hostName = "rapsn-iso-nix-installer";
  zramSwap.enable = true; # save RAM for VMs & small hosts

  services = {
    getty.autologinUser = lib.mkForce "root";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
