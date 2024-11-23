{pkgs, ...}: let
  installer = pkgs.writeShellScriptBin "installer" ''
      #!/usr/bin/env bash

      # Cleanup
      rm -rf dotfiles
      set -euo pipefail

      # Cloneing
      gum style --border normal --margin "1" --padding "1 2" --border-foreground 218 \
        "Welcome to my $(gum style --foreground 218 'NixOS Installer'). (҂◡_◡)"

      gum spin --show-error -s line --title "Cloning the Nixify repository..." -- \
        git clone https://github.com/rgroemmer/dotfiles

      # Choose
      ALL_CONFIGS=$(nix flake show 2>/dev/null ./dotfiles --json | jq -r '.nixosConfigurations | keys[]' | grep -v installer)
      HOST=$(gum choose $ALL_CONFIGS)

      # Installation
      gum spin --show-error -s minidot --title "Preparing disks for $HOST" -- \
      nix run github:nix-community/disko --no-write-lock-file -- --mode zap_create_mount ./dotfiles/hosts/$HOST/disko.nix

      gum spin --show-error -s line --title "Installing NixOS configuration for $HOST" -- \
      nixos-install --flake ./dotfiles#$HOST

      gum style --border normal --margin "1" --padding "1 2" --border-foreground 218 \
        "SUCCESS! Finished installation :3, want to..."

      CHOICE=$(gum choose --item.foreground 218 "Reboot!" "Do nuffin...")
      [[ "$CHOICE" == "Reboot!" ]] && reboot || gum spin -s lint --title "Doing nuffin..." -- sleep 2
  '';
in {
  environment.systemPackages = with pkgs; [
    installer

    # Dependencies for installation
    git
    curl
    gnumake
    gum
    jq
  ];
}
