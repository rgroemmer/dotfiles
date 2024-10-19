{ config, lib, ... }:
let
  cfg = config.stack.k3s;
in
with lib;
{
  options.apps.k3s.network = {
    hostName = mkOpt types.str null "Host name of k3s node";
    address = mkOpt types.str null "IP address of k3s node";
  };

  config = mkIf cfg.enable {
    networking = {
      inherit (cfg.hostName) hostName;
      interfaces.ens18.ipv4.addresses = [
        {
          inherit (cfg.address) address;
          prefixLength = 24;
        }
      ];
      defaultGateway = "192.168.55.1";
      nameservers = [
        "1.1.1.1"
        "8.8.8.8"
      ];

      firewall.allowedTCPPorts = [
        6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
        2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
        2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
      ];
      firewall.allowedUDPPorts = [
        8472 # k3s, flannel: required if using multi-node for inter-node networking
      ];
    };
  };
}
