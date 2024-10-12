{ pkgs, lib, ... }:
let
  installer = (
    pkgs.writeShellScriptBin "installer" ''
            #!/usr/bin/env bash
            set -euo pipefail

            gum style --border normal --margin "1" --padding "1 2" --border-foreground 218 "Hello, there! Welcome my $(gum style --foreground 218 'NixOS Installer')."
            gum spin -s line --title "Cloning the Nixify repository..." -- git clone https://github.com/rgroemmer/dotfiles

            HOST=$(gum choose $(find dotfiles/hosts -mindepth 1 -type d -exec basename {} \;))
            HOST_PATH="./dotfiles/hosts/$HOST"

      	    nix run github:nix-community/disko --no-write-lock-file -- --mode zap_create_mount $HOST_PATH/disko.nix
      	    nixos-install --flake ./dotfiles#$HOST

            echo "SUCCESS! Finished installation :3, want to..."
            CHOICE=$(gum choose --item.foreground 218 "Reboot!" "Do nuffin...")
            [[ "$CHOICE" == "Reboot!" ]] && reboot || gum spin -s lint --title "Doing nuffin..." -- sleep 2
    ''
  );
in
{
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
    gum
    installer
  ];

  system.stateVersion = "24.11";
}
