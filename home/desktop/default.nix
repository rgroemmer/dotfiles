{ pkgs, ... }: {
  imports = [ ./i3.nix ./polybar.nix ./picom.nix ./rofi.nix ];

  home = {
    packages = with pkgs; [

      #----- desktop tools -----#
      nitrogen # wallpaper manager
      redshift # blue light filter
      flameshot
      i3altlayout
      i3status

      #----- programs -----#
      nextcloud-client
      keepassxc
      postman
      vlc
      vscode
      gparted
      xcolor
      drawio
      jetbrains.goland
      gimp
      joplin-desktop

      #----- browsers -----#
      firefox
      vivaldi

      #----- audio tools -----#
      spotify
      pavucontrol

      #----- chat/voice tools -----#
      zoom-us
      discord
      signal-desktop
      mumble
      slack
      rocketchat-desktop

      gnome.gnome-disk-utility

      #----- network/forensics -----#
      wireshark
      nmap

    ];
  };

  programs.home-manager.enable = true;
  manual.manpages.enable = true;
  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    font.name = "";

    theme = {
      name = "Sweet-Dark";
      package = pkgs.sweet;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
