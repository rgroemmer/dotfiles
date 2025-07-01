let
  withTheme = {
    bat.enable = true;
    fzf.enable = true;
    btop.enable = true;
    yazi.enable = true;
  };
in {
  imports = [
    ./alacritty.nix
    ./go.nix
    ./eza.nix
    ./gpg.nix
    ./direnv.nix
    ./zoxide.nix
    ./git.nix
    ./nvim.nix
    ./rust.nix
    ./atuin.nix
    ./lazygit.nix
    ./containers.nix
    ./pet.nix
  ];

  catppuccin = withTheme;
  programs =
    {
      eza.enable = true;
    }
    // withTheme;
}
