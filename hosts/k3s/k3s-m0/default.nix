{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ../common
  ];

  # Only used for initial bootstrap
  system.modules.k3s.clusterInit = true;

  networking = {
    hostName = "k3s-m0";
    hostId = "5851308f";
    interfaces.ens18.ipv4.addresses = [
      {
        address = "192.168.55.50";
        prefixLength = 24;
      }
    ];
  };
}
