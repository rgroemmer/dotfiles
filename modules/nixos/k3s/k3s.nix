{lib, config, ...}:
let
  cfg = config.stack.k3s;
in with lib;
{
  option.stack.k3s = {
    enable = mkEnableOption "k3s";
    serverAddr = mkOpt types.str "" "https://10.0.0.10:6443";
    tokenFile = mkOpt types.str "" "filepath to tokenFile";
    clusterInit = mkEnableOption "initCluster";
    extraFlags = mkOpt types.str "" "";
  };

  config = mkIf cfg.enable {
   services.k3s = {
    enable = true;
    role = "server";

    inherit (cfg) clusterInit serverAddr tokenFile extraFlags;
  };
  };
}
