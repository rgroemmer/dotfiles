{ pkgs, lib, ... }:
{

  #boot = {
  #  initrd.availableKernelModules = [
  #    "ata_piix"
  #    "uhci_hcd"
  #    "virtio_pci"
  #    "virtio_scsi"
  #    "sc_mod"
  #    "sr_mod"
  #  ];
  #};

  #networking.useDHCP = lib.mkDefault true;

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    extraOptions = "experimental-features = nix-command flakes";
  };

  services.openssh.enable = true;
  users.extraUsers.root.password = "nixos";
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqKYXW07z0llbDKRIakLD1PjHe3HxK9iu6czXs+ZU7v iso@rapsn"
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = lib.mkForce [
      "btrfs"
      "reiserfs"
      "vfat"
      "f2fs"
      "xfs"
      "ntfs"
      "cifs"
    ];
  };

  networking.hostName = "iso";
  environment.systemPackages = with pkgs; [ git curl ];

  systemd.services.nixos-install =
    {
      enable = true;
      description = "Bootstrap kube-node";
      unitConfig.Type = "simple";

      wants = ["network-online.target"];
      after = ["network-online.target"];

      script = ''
        #!/usr/bin/env bash
        set -euo pipefail

        cd /tmp
        ${pkgs.git}/bin/git clone https://github.com/rgroemmer/dotfiles.git
        ${pkgs.git}/bin/git checkout iso
        sudo nixos-rebuild switch /tmp/dotfiles#.k8s-node
      '';

      serviceConfig = {
        StandartOutput = "journal+console";
        TTYPath = "/dev/tt1";

        Restart = "on-failure";
        StartLimitInterval = "30s";
        StartLimitBurst = "3";
      };

      wantedBy = [ "multi-user.target" ];
    };

  system.stateVersion = "24.11";
}
