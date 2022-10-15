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

      # lang
      python38
      go

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

      # libraries and helper
      vivaldi-ffmpeg-codecs
    ];
  };
}
