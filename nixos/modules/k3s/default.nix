{lib, ...}: {
  imports = [
    ./service.nix
    ./network.nix
  ];

  options.system.modules.k3s.enable = lib.mkEnableOption "Enable k3s cluster configuration.";
}
