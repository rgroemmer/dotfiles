{
  lib,
  pkgs,
  ...
}:
with lib; {
  imports = [
    ./service.nix
    ./network.nix
  ];

  options.system.modules.k3s = {
    enable = mkEnableOption "Enable k3s cluster configuration.";
    clusterInit = mkEnableOption "Configure first master";
  };

  environment = {
    variables = {
      KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
    };
    systemPackages = with pkgs; [
      kubectl
    ];
  };
}
