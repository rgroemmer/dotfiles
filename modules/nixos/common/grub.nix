{
  lib,
  config,
  pkgs,
  ...
}: let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "grub";
    rev = "v1.0.0";
    hash = "sha256-/bSolCta8GCZ4lP0u5NVqYQ9Y3ZooYCNdTwORNvR7M0=";
  };
  cfg = config.base.grub;
in
  with lib; {
    options.base.grub = {
      enable = mkEnableOption "systemd";
    };

    config = mkIf cfg.enable {
      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        supportedFilesystems = ["ntfs"];
        loader = {
          efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot/efi";
          };
          grub = {
            enable = true;
            theme = "${catppuccin}/src/catppuccin-mocha-grub-theme/";
            useOSProber = true;
            configurationLimit = 15;
            efiSupport = true;
            device = "nodev";
          };
        };
      };
    };
  }
