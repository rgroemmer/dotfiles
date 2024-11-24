{
  pkgs,
  config,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nfs-utils
    kubectl
  ];

  boot.supportedFilesystems = lib.mkForce ["zfs"];

  fileSystems."/mnt/k3s_openebs_main" = {
    device = "192.168.55.10:/main_pool_z2/k3s_openebs_main";
    fsType = "nfs";
    options = ["rw" "vers=4" "noatime"];
  };

  services.k3s = {
    enable = true;
    role = "server";
    package = pkgs.k3s_1_31;
    # TODO: Use sops!
    token = "changeme!";
    clusterInit =
      if config.networking.hostName == "k3s-m0"
      then true
      else false;
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
}
