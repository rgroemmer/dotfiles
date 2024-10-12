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
    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })

    libfido2

    terraform
    rclone

    jq
    kubernetes-helm
    fluxcd
    keepassxc
    stackit-cli

    xdg-utils
    wl-clipboard # pbcopy like

    vault-bin

    ## TODO: look into it
    yazi
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
