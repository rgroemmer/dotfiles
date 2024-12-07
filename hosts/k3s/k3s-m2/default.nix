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
      initialHashedPassword = "$y$j9T$zF5JMtO9DTFc4ViuVyNCr1$PR3tz/qWfg4pfOjCmXAIAtF7bYVqcs7PWq4Wazg2END";
      extraGroups = [];
      extraOptions = {};
    };
    services = {};
    modules = {
      k3s.enable = true;
    };
  };

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
