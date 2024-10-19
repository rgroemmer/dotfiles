{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  base = {
    boot = "systemd";
  };

  stack = {
    k3s = {
      serverAddr = "kubie.rapsn.me";
      tokenFile = "useSOPShere";
      clusterInit = true;
    };
  };

  environment.systemPackages = with pkgs; [kubectl];
  system.stateVersion = "24.11";
}
