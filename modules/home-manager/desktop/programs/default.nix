{pkgs, ...}: {
  imports = [
    ./audio.nix
    ./firefox.nix
    ./chromium.nix

    # Custom binaries
    ./screenshot.nix
  ];

  # Default desktop programs
  home.packages = with pkgs; [
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

  # services = {
  #   nextcloud-client.enable = true;
  #   network-manager-applet.enable = true;
  # };
}
