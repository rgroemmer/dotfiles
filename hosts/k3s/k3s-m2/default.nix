{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ../common
  ];

  networking = {
    hostName = "k3s-m2";
    hostId = "8ecf5ca8";
    interfaces.ens18.ipv4.addresses = [
      {
        address = "192.168.55.52";
        prefixLength = 24;
      }
    ];
  };
}
