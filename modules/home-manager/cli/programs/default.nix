let
  withTheme = {
    bat.enable = true;
    fzf.enable = true;
    btop.enable = true;
    yazi.enable = true;
  };
in {
  imports = [
    # Langs
    ./langs/go.nix
    ./langs/rust.nix

    # Git tools
    ./git.nix
    ./lazygit.nix

    # Editor
    ./nvim.nix

    # Security
    ./gpg.nix
    ./sops.nix

    # Container tools
    ./containers
  ];

  catppuccin = withTheme;
  programs =
    {
      eza.enable = true;
    }
    // withTheme;
}
