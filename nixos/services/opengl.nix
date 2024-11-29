{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.system.services.opengl;
in {
  options.system.services.opengl = mkEnableOption "Enable opengl features.";

  config = mkIf cfg {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [mesa];
      };
    };
  };
}
