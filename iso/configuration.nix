{ pkgs, lib, ... }:
let
  bootstrap-k8s = (
    pkgs.writeShellScriptBin "run" ''
      #!/usr/bin/env bash

      sleep 10
      set -euo pipefail
      git clone https://github.com/rgroemmer/dotfiles
      cd dotfiles

      git checkout iso
      make install-k8s
      reboot
    ''
  );
in
{

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    devSize = "16G";
    supportedFilesystems = lib.mkForce [
      "vfat"
      "ntfs"
    ];
  };

  # autoinstall nixos
  services.cron = {
    enable = true;
    systemCronJobs = [
      "@reboot root ${bootstrap-k8s}/bin/run &>/tmp/nix_install.log"
    ];
  };

  networking.hostName = "iso";

  # try to save RAM
  zramSwap.enable = true;

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
  services.getty.autologinUser = lib.mkForce "root";
  users.users.root.hashedPassword = "$y$j9T$EMO/EfdbflSVB//fPjqSi/$3jrcxQr/AEXtJZSXtc0ISAZbnqum.TW9vIi8bgMA2F1";
  users.users.root.initialHashedPassword = lib.mkForce null;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqKYXW07z0llbDKRIakLD1PjHe3HxK9iu6czXs+ZU7v iso@rapsn"
  ];

  environment.systemPackages = with pkgs; [
    git
    curl
    gnumake
    bootstrap-k8s
  ];

  system.stateVersion = "24.11";
}
