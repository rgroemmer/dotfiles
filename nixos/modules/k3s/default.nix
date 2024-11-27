{lib, ...}: with lib; {
  imports = [
    ./service.nix
    ./network.nix
    ./storage.nix
  ];

  options.modules.k3s = {
    enable = mkEnableOption "Enable k3s cluster configuration.";
    clusterInit = mkEnableOption "Toggle first master for cluster initialization.";
  };
}
