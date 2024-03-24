{ pkgs, ... }:
{
  imports = [
    ./audio.nix
    ./vscode.nix
    ./firefox.nix
    ./chromium.nix
  ];

  # Default desktop programs
  home.packages = with pkgs; [
    # screenshoters
    grimblast
    slurp
    sway-contrib.grimshot

    keepassxc
    vlc
    gparted
    exodus
    gnome.gnome-disk-utility

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
