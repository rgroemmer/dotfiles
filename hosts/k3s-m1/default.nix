{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    # nixos modules
    ../../nixos/common
    ../../nixos/k3s
  ];

  # Roles

  # Host specific configuration
  networking = {
    hostName = "k3s-m1";
    interfaces.ens18.ipv4.addresses = [
      {
        address = "192.168.55.21";
        prefixLength = 24;
      }
    ];
  };
}
