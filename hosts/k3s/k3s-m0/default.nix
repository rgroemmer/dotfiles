{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ../common
  ];

  # Host specific configuration
  system = {
    boot = {
      systemd = true;
    };
    user = {
      name = "rap";
      initialHashedPassword = "$y$j9T$8uQSJbY6w9kjXnj74JKjA1$pWYgNf.gb497suX//oIw6aggEPoD2Xv1kvMKZfDTOU/";
      extraGroups = [];
      extraOptions = {};
    };
    services = {};
    modules = {
      k3s = {
        enable = true;
        clusterInit = true;
      };
    };
  };

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
