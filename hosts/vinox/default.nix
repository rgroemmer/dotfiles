{
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"

    ../../nixos

    ./installer.nix
    ./diagnostics.nix
  ];

  # Host specific configuration
  system = {
    boot = {
      systemd = true;
      supportedFilesystems = ["ntfs"];
    };
    user = {
      name = "root";
      initialHashedPassword = "";
      extraOptions = {};
      extraGroups = [];
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqKYXW07z0llbDKRIakLD1PjHe3HxK9iu6czXs+ZU7v";
    };
    services = {};
  };

  environment.systemPackages = [
    inputs.neonix.packages.${pkgs.system}.default
  ];

  services.xserver.desktopManager.gnome = {
    favoriteAppsOverride = ''
      [org.gnome.shell]
      favorite-apps=[ 'firefox.desktop', 'alacritty.desktop', 'org.gnome.Nautilus.desktop', 'gparted.desktop', 'wireshark.desktop' ]
    '';
    enable = true;
  };

  networking.hostName = "vinox";
  zramSwap.enable = true; # save RAM for VMs & small hosts

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
