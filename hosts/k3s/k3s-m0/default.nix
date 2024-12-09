{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    ../common
  ];

  system.modules.k3s.enable = false;

  services.k3s.serverAddr = lib.mkForce "";

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
