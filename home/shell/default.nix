{ pkgs, ... }: {
  imports = [ ./alacritty.nix ./zsh.nix ./git.nix ./files.nix ];

  # shell packages
  home = {
    packages = with pkgs; [

      #----- kubernetes tools -----#
      kubectl
      k9s
      kind
      docker
      kubernetes-helm
      kubeswitch

      #----- cli default tools  -----#
      ripgrep
      xclip
      file
      bc
      bat
      exa
      gh
      jq
      wget
      unzip
      gnumake
      gotop
      ranger
      yq-go
      glow # pretty markdown viewer
      gettext
      #TODO: get neovim flake configurated
      openssl
      nerdfonts

      #----- cli tools -----#
      terraform
      vault
      openstackclient

      #----- languages -----#
      python38

      #----- compilers -----#
      gcc
    ];
  };

  programs = {
    home-manager.enable = true;

    command-not-found.enable = true;

    zoxide.enable = true;
    jq.enable = true;
    bat.enable = true;

    go = {
      enable = true;
      package = pkgs.go_1_18;
      goPath = "go";
      goBin = "go/bin";
      goPrivate = [ "github.com/stackitcloud" ];
    };

    fzf = {
      enable = true;
      defaultCommand =
        "fd --type f --hidden --follow --exclude .git --exclude .vim --exclude .cache --exclude vendor";
      defaultOptions = [
        "--border sharp"
        "--inline-info"
        "--bind ctrl-h:preview-down,ctrl-l:preview-up"
      ];
    };

    tmux = {
      enable = true;
      extraConfig = ''
        set-option -g prefix C-a
        set -g base-index 1
        setw -g aggressive-resize on
      '';
      plugins = with pkgs; [ tmuxPlugins.onedark-theme ];
    };

    gpg = {
      enable = true;
    };
  };
}
