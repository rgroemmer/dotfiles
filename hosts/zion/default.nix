{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    # nixos modules
    ../../nixos/common
    ../../nixos/desktop
  ];

  # host specific configuration
  boot = {
    binfmt.emulatedSystems = ["aarch64-linux"];
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = ["ntfs"];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      systemd-boot.enable = false;
      grub = let
        catppuccin = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "grub";
          rev = "v1.0.0";
          hash = "sha256-/bSolCta8GCZ4lP0u5NVqYQ9Y3ZooYCNdTwORNvR7M0=";
        };
      in {
        enable = true;
        theme = "${catppuccin}/src/catppuccin-mocha-grub-theme/";
        useOSProber = true;
        configurationLimit = 15;
        efiSupport = true;
        device = "nodev";
      };
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true; # realtime-kit
    sudo.wheelNeedsPassword = false;
    pam.services.swaylock.text = "auth include login"; # enable swaylock to login
  };

  networking = {
    hostName = "zion";
    networkmanager.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [qt6.qtwayland];

    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
  };

  services.udev.packages = with pkgs; [
    qmk-udev-rules
    android-udev-rules
  ];
}
