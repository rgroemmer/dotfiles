{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.system.services.sound;
in {
  options.system.services.sound = mkEnableOption "Enable sound.";

  config = mkIf cfg {
    services = {
      pulseaudio.enable = false;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
    };
  };
}
