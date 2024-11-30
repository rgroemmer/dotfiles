{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.system.modules.k3s.enable;
in {
  imports = [
    ./service.nix
    ./network.nix
  ];

  options.system.modules.k3s = {
    enable = mkEnableOption "Enable k3s cluster configuration.";
    clusterInit = mkEnableOption "Configure first master";
  };

  config = mkIf cfg {
    environment = {
      shellAliases = {
        k = "kubectl";
      };
      variables = {
        KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
      };
      systemPackages = with pkgs; [
        kubectl
      ];
    };
  };
}
