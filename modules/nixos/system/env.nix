{
  pkgs,
  inputs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      dnsutils # dig, nslookup, etc.
      inetutils # ping, traceroute, etc.

      # Cpu & Networking tools
      htop
      curl

      # Programs
      git
      inputs.neonix.packages.${pkgs.system}.mini

      fzf
    ];
    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };
}
