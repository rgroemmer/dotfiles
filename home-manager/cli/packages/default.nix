{pkgs, ...}: {
  programs = {
    home.packages = with pkgs; [
      # Core utility
      coreutils # cp, mv, etc.
      moreutils # parallel, pee, etc.
      dnsutils # dig, nslookup, etc.
      gnumake
      unzip

      # Text processing
      jq
      yq

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
  };
}
