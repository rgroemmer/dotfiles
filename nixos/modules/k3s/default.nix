{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.system.modules.k3s.enable;
  getConfig = pkgs.writeShellScriptBin "getConfig" ''
    #!/usr/bin/env bash

    mkdir -p ~/.kube/
    sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
    sudo chown k3s:users ~/.kube/config
  '';
in {
  imports = [
    ./service.nix
    ./network.nix
  ];

  options.system.modules.k3s = {
    enable = mkEnableOption "Enable k3s cluster configuration.";
    clusterInit = mkEnableOption "Enable initial cluster initialiastion";
  };

  config = mkIf cfg {
    environment = {
      shellAliases = {
        k = "kubectl";
      };
      systemPackages = with pkgs; [
        getConfig
        kubectl
      ];
    };
  };
}
