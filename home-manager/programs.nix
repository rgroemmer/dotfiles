{pkgs}: {
  home.packages = with pkgs; [
    # core utilities
    coreutils
    moreutils
    dnsutils
    gnumake
    (nerdfonts.override {fonts = ["CascadiaCode"];})

    libfido2

    terraform
    rclone

    jq
    kubernetes-helm
    fluxcd
    keepassxc
    stackit-cli

    xdg-utils
    wl-clipboard # pbcopy like

    vault-bin

    ## TODO: look into it
    yazi
    ## TODO end

    nixfmt-rfc-style
    #nvtopPackages.amd
    unzip
    sops
    gh
    kubectl
    openssh

    xorg.xhost
  ];
}
