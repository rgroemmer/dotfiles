{pkgs, ...}: let
  screenshoot = pkgs.writeShellScriptBin "screenshoot" ''
    #!/usr/bin/env bash

    grimblast save area
  '';
in {
  imports = [
    ./audio.nix
    ./vscode.nix
    ./firefox.nix
    ./chromium.nix
    ./binaries.nix
  ];

  # Default desktop programs
  home.packages = with pkgs; [
    # screenshoters
    grimblast
    slurp
    sway-contrib.grimshot
    screenshoot

    vlc
    gparted

    gnome-disk-utility

    #TODO: check out
    pkgs.xdg-desktop-portal-hyprland
  ];

  programs = {
    spotify-player.enable = true;
  };

  services = {
    nextcloud-client.enable = true;
    network-manager-applet.enable = true;
  };
}
