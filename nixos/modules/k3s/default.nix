{lib, ...}: with lib; {
  imports = [
    ./service.nix
    ./network.nix
    ./storage.nix
  ];

  options.system.modules.k3s.enable = mkEnableOption "Enable k3s cluster configuration.";
}
