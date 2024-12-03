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
    ./rust.nix
  ];

  programs = {
    eza.enable = true; # ls with icons
    bat = enableWithCatppuccin;
    fzf = enableWithCatppuccin;
    lazygit = enableWithCatppuccin;
    btop = enableWithCatppuccin; # better htop
    yazi = enableWithCatppuccin; # term explorer
  };
}
