{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.system.modules.k3s.enable;
in {
  imports = [
    ./service.nix
    ./network.nix
  ];

  options.system.modules.k3s.enable = mkEnableOption "Enable k3s cluster configuration.";

  config = mkIf cfg {
    environment = {
      shellAliases = {
        k = "kubectl";
      };
      systemPackages = with pkgs; [
        kubectl
      ];
    };
  };
}
