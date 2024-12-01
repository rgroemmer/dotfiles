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
      initialHashedPassword = "$y$j9T$bPx.oxwth.D4a4cjRa30u1$z8KEAOTdDGl.YHrsRsZVOlaikPlmoFDxrVFJl7AcHF7";
      extraGroups = [];
      extraOptions = {};
    };
    services = {};
    modules = {
      k3s.enable = true;
    };
  };

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
