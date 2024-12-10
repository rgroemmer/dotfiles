{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      dnsutils # dig, nslookup, etc.
      inetutils # ping, traceroute, etc.

      # Cpu & Networking tools
      htop
      curl

      # Programs
      git
      neovim

      fzf
    ];
    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };
}
