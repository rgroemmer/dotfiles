{ pkgs, ... }: {
  imports = [ ./user.nix ./alacritty.nix ./zsh.nix ./i3.nix ./polybar.nix ];

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
      font = "FuraMono Nerd Font Mono 12";

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

}
