{ pkgs, lib, ... }:
{

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    runSize = "30G";
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

  swapDevices = [{
    device = "/run/swapfile";
    size = 16*1024;
  }];

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
  users.users.root.password = "nixos";
  users.users.root.initialHashedPassword = lib.mkForce null;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqKYXW07z0llbDKRIakLD1PjHe3HxK9iu6czXs+ZU7v iso@rapsn"
  ];

  environment.systemPackages = with pkgs; [
    git
    curl
  ];

  # gnome power settings do not turn off screen
  systemd = {
    services.sshd.wantedBy = pkgs.lib.mkForce ["multi-user.target"];
    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };

  system.stateVersion = "24.11";
}
