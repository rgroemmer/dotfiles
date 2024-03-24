{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    #TODO: move packages to their respective home
    vscode
    nixfmt
    neovim
    kitty
    firefox
    alacritty
    moreutils
    nvtop-amd
    htop
    unzip
    gnupg
    keepassxc
    sops
    bat
  ];

  programs.eza.enable = true;
  programs.lazygit.enable = true;

  programs.gpg.enable = true;
  programs.zoxide.enable = true;
}

