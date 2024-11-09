{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.base.systemd;
in
  with lib; {
    options.base.systemd = {
      enable = mkEnableOption "systemd";
    };

    config = mkIf cfg.enable {
      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        supportedFilesystems = ["ntfs"];
        loader.efi.canTouchEfiVariables = true;
        loader.systemd-boot.enable = true;
      };
    };
  }
