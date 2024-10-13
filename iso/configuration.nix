{ pkgs, lib, ... }:
let
  installer = (
    pkgs.writeShellScriptBin "installer" ''
            #!/usr/bin/env bash
            set -euo pipefail

            rm -rf dotfiles

            gum style --border normal --margin "1" --padding "1 2" --border-foreground 218 "Hello, there! Welcome my $(gum style --foreground 218 'NixOS Installer')."
            gum spin -s line --title "Cloning the Nixify repository..." -- git clone https://github.com/rgroemmer/dotfiles

            HOST=$(gum choose $(nix flake show ./dotfiles --json | jq -r '.nixosConfigurations | keys[]' | grep -v iso))

            if [[ "$HOST" == *"k3s"* ]] then
              DISKO_CONFIG="./dotfiles/hosts/kube-m0/disko.nix"
            else
              DISKO_CONFIG="./dotfiles/hosts/$HOST/disko.nix"
            fi

      	    nix run github:nix-community/disko --no-write-lock-file -- --mode zap_create_mount "$DISKO_CONFIG"
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

  networking = {
    hostName = "rapsn-iso-nix-installer";
    interfaces.ens18.ipv4 = {
      addresses = [
        {
          address = "192.168.55.253";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = "192.168.55.1";
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };

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
    jq
    installer
  ];

  system.stateVersion = "24.11";
}
