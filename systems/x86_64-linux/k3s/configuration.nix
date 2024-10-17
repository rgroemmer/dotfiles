{
  pkgs,
  lib,
  config,
  ...
}:
let
  clusterDNS = "api.k3s.rapsn.me";
  hostName = config._module.specialArgs.name;
  addresses = [
    {
      inherit (config._module.specialArgs) address;
      prefixLength = 24;
    }
  ];
in
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
  };

  services.openssh.enable = true;

  users.users.root = {
    hashedPassword = "$y$j9T$EMO/EfdbflSVB//fPjqSi/$3jrcxQr/AEXtJZSXtc0ISAZbnqum.TW9vIi8bgMA2F1";
    initialHashedPassword = lib.mkForce null;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqKYXW07z0llbDKRIakLD1PjHe3HxK9iu6czXs+ZU7v iso@rapsn"
    ];
  };

  networking = {
    inherit hostName;
    interfaces.ens18.ipv4.addresses = addresses;
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

  environment.systemPackages = with pkgs; [
    git
    curl
    neovim
    kubectl
  ];

  system.stateVersion = "24.11";

  # Service area
  services.k3s = {
    enable = true;
    role = "server";
    # todo: encrypt
    token = "1234";
    clusterInit = if hostName == "k3s-m0" then true else false;
    serverAddr = if hostName == "k3s-m0" then "" else clusterDNS;
  };
}