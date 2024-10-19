{ config, lib, ... }:
let
  cfg = config.apps.k3s.network;
in
with lib;
{
  options.apps.k3s.network = {
  };

  networking = {
    inherit (config._module.specialArgs.name) hostname;
    interfaces.ens18.ipv4.addresses = [
      {
        inherit (config._module.specialArgs) address;
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
}
