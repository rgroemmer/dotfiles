{ pkgs, ... }:
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
        DISKO_CONFIG="./dotfiles/hosts/k3s-m0/disko.nix"
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

  environment.systemPackages = with pkgs; [
    git
    curl
    gnumake
    gum
    jq
    installer
  ];

}
