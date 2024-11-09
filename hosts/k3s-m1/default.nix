{
  imports = [
    ../common
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
