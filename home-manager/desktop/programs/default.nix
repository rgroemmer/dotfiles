{pkgs, ...}: let
  screenshoot = pkgs.writeShellScriptBin "screenshoot" ''
    #!/usr/bin/env bash

    grimblast save area
  '';
in {
  imports = [
    # TODO: make configurable
    # ./audio.nix
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

    pciutils

    mumble

    stackit-cli
    openstackclient-full

    vault-bin
  ];

  # programs = {
  #   spotify-player.enable = true;
  # };

  # services = {
  #   nextcloud-client.enable = true;
  #   network-manager-applet.enable = true;
  # };
}
