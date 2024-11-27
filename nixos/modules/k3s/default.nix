{lib, ...}: {
  imports = [
    ./service.nix
    ./network.nix
    ./storage.nix
  ];

  options.modules.k3s.enable = lib.mkEnableOption "Enable k3s cluster configuration";
}
