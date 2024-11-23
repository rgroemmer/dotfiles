{ inputs, ... }: {
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
    interfaces.ens18.ipv4.addresses = [
      {
        address = "192.168.55.20";
        prefixLength = 24;
      }
    ];
  };
}
