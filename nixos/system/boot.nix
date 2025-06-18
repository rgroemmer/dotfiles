{
  lib,
  config,
  ...
}:
with lib; let
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
    catppuccin.grub.enable = true;

    boot = {
      inherit (cfg) supportedFilesystems;
      binfmt.emulatedSystems = mkIf cfg.armSupport ["aarch64-linux"];

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
