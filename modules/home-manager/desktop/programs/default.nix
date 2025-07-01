{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    # Tools
    ./audio.nix
    ./tray.nix

    # Programs
    ./spotify.nix
    ./nextcloud.nix

    # Browsers
    ./firefox.nix
    ./chromium.nix

    # Custom shell scripts
    ./screenshot.nix
  ];

  # Default desktop programs
  home.packages = with pkgs; let
  in
    [
      xfce.thunar
      vlc
      gparted
      gnome-disk-utility
    ]
    ++ lib.options config.roles.workdevice [
      mumble
      stackit-cli
      openstackclient-full
      vault-bin
    ];
}
