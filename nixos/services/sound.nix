{
  lib,
  config,
  ...
}: let
  cfg = config.system.services.sound;
in
  with lib; {
    options.system.services.sound = mkEnableOption "Enable sound.";

    config = mkIf cfg {
      hardware.pulseaudio.enable = lib.mkForce false;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
    };
  }
