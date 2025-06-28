{pkgs, ...}: let
  screenshoot = pkgs.writeShellScriptBin "screenshoot" ''
    #!/usr/bin/env bash

    grimblast save area
  '';
in {
  imports = [
    ./audio.nix
    ./firefox.nix
    ./chromium.nix
    ./binaries.nix
  ];

  # Default desktop programs
  # TODO: Move and cleanup
  home.packages = with pkgs; [
    # screenshoters
    grimblast
    slurp
    sway-contrib.grimshot
    screenshoot

    xfce.thunar

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
}
