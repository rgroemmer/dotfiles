{
  lib,
  config,
  ...
}: let
  cfg = config.system.services.bluetooth;
in
  with lib; {
    options.system.services.bluetooth = mkEnableOption "Enable bluetooth features.";

    config = mkIf cfg {
      hardware.bluetooth.enable = true;
      services.blueman.enable = true;
    };
  }
