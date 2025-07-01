{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.system.boot;
in {
  options.system.boot = {
    systemd = mkEnableOption "Enable systemd-boot as lightweight bootloader";
    grub = mkEnableOption "Enable grub as beautiful bootloader";
    armSupport = mkEnableOption "Enable arm cross-compiler support";
    supportedFilesystems = mkOption {
      type = with types; listOf str;
      default = [];
    };
  };

  config = {
    catppuccin = mkIf cfg.grub {
      grub.enable = true;
      plymouth.enable = true;
    };

    boot = {
      inherit (cfg) supportedFilesystems;
      binfmt.emulatedSystems = mkIf cfg.armSupport ["aarch64-linux"];

      plymouth = mkIf cfg.grub {
        enable = true;
      };

      consoleLogLevel = mkIf cfg.grub 3;
      initrd.verbose = mkIf cfg.grub false;
      kernelParams = mkIf cfg.grub [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];
      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key
      # It will just not appear on screen unless a key is pressed
      loader.timeout = mkIf cfg.grub 0;

      loader = {
        systemd-boot.enable = cfg.systemd;

        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint =
            if cfg.grub
            then "/boot/efi" # Important when using grub to actually boot into grub-menu.
            else "/boot";
        };

        grub = mkIf cfg.grub {
          enable = true;
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
