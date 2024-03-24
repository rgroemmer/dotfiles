{ pkgs, lib, ... }:
{

  imports = [
    ./hardware-configuration.nix
    ../../nixos
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      theme = "${
        (pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "grub";
          rev = "v1.0.0";
          hash = "sha256-/bSolCta8GCZ4lP0u5NVqYQ9Y3ZooYCNdTwORNvR7M0=";
        })
      }/src/catppuccin-mocha-grub-theme/";
      useOSProber = true;
      configurationLimit = 15;
      efiSupport = true;
      device = "nodev";
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true; # realtime-kit
    sudo.wheelNeedsPassword = false;
    pam.services.swaylock.text = "auth include login"; # enable swaylock to login
  };

  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "zion";
    networkmanager.enable = true;
  };

  programs.xfconf.enable = true;

  environment = {
    systemPackages = with pkgs; [
      htop
      curl
      git
      vim
      gparted
      qt6.qtwayland
    ];

    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };
}
