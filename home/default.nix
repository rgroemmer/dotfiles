{ pkgs, ... }: {
  imports = [ ./user.nix ./alacritty.nix ./zsh.nix ./i3.nix ];

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

}
