{ pkgs, lib, ... }:
let
  bootstrap-k8s = (
    pkgs.writeShellScriptBin "run" ''
      #!/usr/bin/env bash
      git clone https://github.com/rgroemmer/dotfiles
      cd dotfiles

      git checkout iso
      make install-k8s
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

  networking.hostName = "iso";

  # try to save RAM
  zramSwap.enable = true;
  swapDevices = [
    {
      device = "/dev/swapfile";
      size = 8192;
    }
  ];

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
