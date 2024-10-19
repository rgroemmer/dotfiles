{ pkgs, ... }:
{
  programs.zsh.enable = true;

  environment = {
    pathsToLink = [ "/share/zsh" ]; # autocompletion
    systemPackages = with pkgs; [
      htop
      curl
      git
      vim
      gparted
    ];
  };

  variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };
}
