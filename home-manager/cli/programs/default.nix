let
  enableWithCatppuccin = {
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
    bat = enableWithCatppuccin;
    fzf = enableWithCatppuccin;
    lazygit = enableWithCatppuccin;
  };
}
