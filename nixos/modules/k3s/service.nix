{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.k3s;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nfs-utils
      zfs
      kubectl
    ];

    services.k3s = {
      enable = true;
      role = "server";
      package = pkgs.k3s_1_31;
      # TODO: Use sops!
      token = "changeme!";
      inherit (cfg) clusterInit;
      serverAddr = "https://api.k3s.rapsn.me";

      # Configuration
      configPath = builtins.toFile "config.yaml" ''
        node-label:
          - "node.rapsn.me/os=nixos"
        tls-san:
          - api.k3s.rapsn.me
        etcd-expose-metrics: true
        kube-controller-manager-arg:
          - "bind-address=0.0.0.0"
        kube-scheduler-arg:
          - "bind-address=0.0.0.0"
        kube-proxy-arg:
          - "metrics-bind-address=0.0.0.0"

        # critical config values (required on all nodes) https://docs.k3s.io/cli/server#critical-configuration-values
        cluster-cidr: 10.42.0.0/16,fd42::/56
        service-cidr: 10.43.0.0/16,fd43::/112
        disable-helm-controller: true
        disable:
          - servicelb
          - traefik
          - local-storage
      '';
    };
  };
}
