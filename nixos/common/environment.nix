{pkgs, ...}: {
  environment = {
    pathsToLink = ["/share/zsh"]; # autocompletion
    systemPackages = with pkgs; [
      htop
      curl
      git
      neovim
      gparted
    ];
    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };
  system.stateVersion = "24.11";
}
