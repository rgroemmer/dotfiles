{ pkgs, ... }: {
  imports = [ ./user.nix ./alacritty.nix ./zsh.nix ./i3.nix ./polybar.nix ./picom.nix ./rofi.nix ./work.nix ];

  programs = {
    git = {
      enable = true;
      userName = "Raphael Groemmer";
      userEmail = "r.groemmer@yahoo.de";
      #todo create signing key
      # signing = {
      #   key = "937F956B9008A22F";
      #   signByDefault = true;
      # };
    };
  };

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
