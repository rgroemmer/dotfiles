{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix

    inputs.disko.nixosModules.disko
    ./disko.nix

    # nixos modules
    ../../nixos/common
    ../../nixos/k3s
  ];

  # Roles

  # Host specific configuration
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
