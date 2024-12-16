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

    cd dotfiles

    # Branch selection (for development)
    BRANCH=$(git branch -r | grep -v "\->" | awk -F'/' '{print $2}' | gum choose)
    git checkout $BRANCH

    # Choose
    ALL_CONFIGS=$(nix flake show 2>/dev/null --json | jq -r '.nixosConfigurations | keys[]' | grep -v installer)
    HOST=$(gum choose $ALL_CONFIGS)
    DISKO_CONFIG="./hosts/$HOST/disko.nix"

    [[ $HOST == "k3s-m"* ]] && DISKO_CONFIG="./hosts/k3s/common/disko.nix"

    # Installation
    # Disko
    gum spin --show-error -s line --title "Preparing disks for $HOST" -- \
      nix run github:nix-community/disko --no-write-lock-file -- --mode zap_create_mount "$DISKO_CONFIG"

    # NixOS
    gum spin --show-error -s line --title "Installing NixOS configuration for $HOST" -- \
      nixos-install --flake .#$HOST
    reboot
  '';
in {
  environment.systemPackages = with pkgs; [
    installer
    gum
  ];
}
