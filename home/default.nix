{ pkgs, ... }: {
  imports = [ ./user.nix ./alacritty.nix ./zsh.nix ./i3.nix ./polybar.nix ./picom.nix ];

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
    rofi = {
      enable = true;
      cycle = true;
      font = "Source Sans Pro 10";

      # TODO generate theme
      theme = ../config/rofi.config;
      extraConfig = {
        kb-remove-to-eol = "";
        kb-accept-entry = "Return";
        kb-row-up = "Control+k";
        kb-row-down = "Control+j";
      };
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
