{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./k9s.nix
    ./fzf.nix
    ./lazygit.nix
    ./bat.nix
    ./git.nix
  ];

  # Default CLI programs
  home.packages = with pkgs; [
    # core utilities
    coreutils
    moreutils
    dnsutils
    gnumake
    yabai
    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })

    iterm2
    keepassxc

    xdg-utils
    wl-clipboard # pbcopy like

    ## TODO: look into it
    yazi
    timewarrior
    taskwarrior
    ## TODO end

    nixfmt-rfc-style
    #nvtopPackages.amd
    unzip
    sops
    gh
    kubectl

    xorg.xhost
  ];

  programs = {

    go = {
      enable = true;
      package = pkgs.go;
      goPath = "go";
      goBin = "go/bin";
      goPrivate = [
        "github.com/stackitcloud"
        "dev.azure.com/*"
      ];
    };

    eza.enable = true;
    zoxide.enable = true;
    gpg.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
