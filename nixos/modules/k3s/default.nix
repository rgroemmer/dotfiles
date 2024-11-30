{lib, ...}:
with lib; {
  imports = [
    ./service.nix
    ./network.nix
  ];

  options.system.modules.k3s = {
    enable = mkEnableOption "Enable k3s cluster configuration.";
    clusterInit = mkEnableOption "Configure first master";
  };
}
