{pkgs, ...}: {
  home.packages = with pkgs; [
    # Core utility
    coreutils # cp, mv, etc.
    moreutils # parallel, pee, etc.
    dnsutils # dig, nslookup, etc.
    gnumake
    gnutar
    gzip
    unzip
    gnused
    gnugrep

    # Inspection
    htop

    # Network tools
    inetutils
    curl
    wget

    # Network inspetion
    termshark
    nmap
    netcat
    tcpdump

    # Text processing
    jq
    yq
    gawk

    # Find utils
    fd
    ripgrep

    # Copy tools
    rclone

    # SSH / Security
    openssh
    libfido2
    #keepassxc
    sops

    # Clipboard
    wl-clipboard

    # Note taking
    obsidian
  ];
}
