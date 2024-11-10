let
  withCatppuccin = {
    enable = true;
    catppuccin.enable = true;
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
  ];

  programs = {
    eza.enable = true;
    bat = withCatppuccin;
    fzf = {
      enable = true;
      catppuccin.enable = true;
    };
    lazygit = {
      enable = true;
      catppuccin.enable = true;
    };
  };
}
