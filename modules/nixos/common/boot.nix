{
  pkgs,
  config,
  lib,
  ...
}:
let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "grub";
    rev = "v1.0.0";
    hash = "sha256-/bSolCta8GCZ4lP0u5NVqYQ9Y3ZooYCNdTwORNvR7M0=";
  };

  systemd = {
        kernelPackages = pkgs.linuxPackages_latest;
        supportedFilesystems = [ "ntfs" ];
        loader.efi.canTouchEfiVariables = true;
        loader.systemd-boot.enable = true;
  };

  grub = {
        kernelPackages = pkgs.linuxPackages_latest;
        supportedFilesystems = [ "ntfs" ];
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

  cfg = config.stack.boot;
in
with lib;
{

  options.stack.boot = {
    grub.enable = mkEnableOption "grub";
  };

  config = {
    boot = if cfg.grub.enable then grub else systemd;
  };
}
