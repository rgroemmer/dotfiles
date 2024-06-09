{
  pkgs,
  ...
}:
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

    xdg-utils
    wl-clipboard # pbcopy like

    nixfmt-rfc-style
    nvtopPackages.amd
    unzip
    sops

    xorg.xhost

    neovim
  ];

  programs = {
    eza.enable = true;
    zoxide.enable = true;
    gpg.enable = true;
  };
}
