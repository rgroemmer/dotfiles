{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.system.services.tailscale;
in {
  options.system.services.tailscale = mkEnableOption "Enable tailscaled.";

  config = mkIf cfg {
    services.tailscale.enable = true;
  };
}
