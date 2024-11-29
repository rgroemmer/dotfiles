{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.system.modules.k3s.enable;
in {
  config = mkIf cfg {
    networking = {
      defaultGateway = "192.168.55.1";
      nameservers = [
        "1.1.1.1"
        "8.8.8.8"
      ];

      firewall.allowedTCPPorts = [
        6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
        2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
        2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
        # Metrics
        2381 # etcd
        9100 # node-exporter
        10249 # kube-proxy
        10250 # kublet
        10257 # kube-controller-manager
        10259 # kube-scheduler
      ];
      firewall.allowedUDPPorts = [
        8472 # k3s, flannel: required if using multi-node for inter-node networking
      ];
    };
  };
}
