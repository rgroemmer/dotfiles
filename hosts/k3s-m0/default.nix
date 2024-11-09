{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    # import nixos configuration

  ];

  base = {
    systemd.enable = true;
  };

  stack = {
    k3s = {
      serverAddr = "kubie.rapsn.me";
      tokenFile = "useSOPShere";
      clusterInit = true;
    };
  };
}
