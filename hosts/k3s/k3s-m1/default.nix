{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ../common
  ];

  system.modules.k3s.enable = false;

  networking = {
    hostName = "k3s-m1";
    hostId = "a52824e8";
    interfaces.ens18.ipv4.addresses = [
      {
        address = "192.168.55.51";
        prefixLength = 24;
      }
    ];
  };
}
