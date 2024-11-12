{pkgs, ...}: {
  environment = {
    pathsToLink = ["/share/zsh"]; # autocompletion
    systemPackages = with pkgs; [
      # Core utility
      coreutils # cp, mv, etc.
      moreutils # parallel, pee, etc.
      dnsutils # dig, nslookup, etc.
      gnumake
      gnutar
      gnused
      gnugrep
      unzip

      # cpu & networking tools
      htop
      curl

      # programs
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
