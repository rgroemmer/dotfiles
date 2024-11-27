{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      # Global common packages available for all hosts / isos
      coreutils # cp, mv, etc.
      moreutils # parallel, pee, etc.
      dnsutils # dig, nslookup, etc.
      gnumake
      gnutar
      gnused
      gnugrep
      unzip

      # Cpu & Networking tools
      htop
      curl

      # Programs
      git
      neovim
      gparted
    ];
  };
}
