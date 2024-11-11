{pkgs, ...}: {
  home.packages = with pkgs; [
    # Core utility
    coreutils # cp, mv, etc.
    moreutils # parallel, pee, etc.
    dnsutils # dig, nslookup, etc.
    gnumake
    gnutar
    gnused
    gnugrep
    unzip

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

    # Nerdfont
    (nerdfonts.override {fonts = ["CascadiaCode"];})

    # SSH / Security
    openssh
    libfido2
    keepassxc
    sops

    # Clipboard
    wl-clipboard
  ];
}
