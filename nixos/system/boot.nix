{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "grub";
    rev = "v1.0.0";
    hash = "sha256-/bSolCta8GCZ4lP0u5NVqYQ9Y3ZooYCNdTwORNvR7M0=";
  };
  cfg = config.system.boot;
in {
  options.system.boot = {
    systemd = mkEnableOption "Enable systemd-boot";
    grub = mkEnableOption "Enable grub";
    armSupport = mkEnableOption "Enable arm cross-compiler support";
    supportedFilesystems = mkOption {
      type = with types; listOf str;
      default = [];
    };
  };

  config = {
    boot = {
      inherit (cfg) supportedFilesystems;
      binfmt.emulatedSystems = mkIf cfg.armSupport ["aarch64-linux"];

      loader = {
        systemd-boot.enable = cfg.systemd;

        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };

        grub = mkIf cfg.grub {
          enable = true;
          theme = "${catppuccin}/src/catppuccin-mocha-grub-theme/";
          useOSProber = true;
          configurationLimit = 15;
          efiSupport = true;
          device = "nodev";
        };
      };
    };

    assertions = [
      {
        assertion =
          if cfg.grub == null && cfg.systemd == null
          then false
          else true;
        message = "You must set in host config: system.boot.grub or system.boot.systemd to make system bootable";
      }
    ];
  };
}
