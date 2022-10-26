{ pkgs, ... }: {
  # manage itself
  programs.home-manager.enable = true;
  manual.manpages.enable = true;
  # allow installation of fonts
  fonts.fontconfig.enable = true;

  home = {
    keyboard.layout = "de";

    packages = with pkgs; [
      # cli tools
      xclip
      gh
      ripgrep
      bat
      exa
      bind
      jq
      yq
      vault
      wget
      unzip
      terraform
      gnumake
      docker

      gotop
      # lang
      python38
      go
      gcc

      # kubernetes tools
      kubectl
      k9s

      # chat tools
      zoom-us
      signal-desktop
      mumble
      slack
      rocketchat-desktop


      # gui tools
      nitrogen # wallpaper manager
      firefox
      flameshot
      nextcloud-client
      keepassxc
      postman
      vivaldi
      vlc
      vscode
      spotify
      gparted
      xcolor
      pavucontrol
      discord
      drawio
      jetbrains.goland

      kubeswitch

      redshift # blue light filter

      i3altlayout

      ranger
      
      # libraries and helper
      vivaldi-ffmpeg-codecs

      #TODO switch to krewfile
      krew
    ];
  };
}
