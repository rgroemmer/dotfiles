{
  imports = [
    ./alacritty.nix
    ./git.nix
  ];

  programs = {
    bat = {
      enable = true;
      catppuccin.enable = true;
    };
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
