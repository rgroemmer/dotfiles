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
    system.activationScripts.mybootstrap.text = ''
      KUBE_PATH="/home/k3s/.kube"
      if [[ ! -f "$KUBE_PATH/config" ]]; then
        mkdir -p $KUBE_PATH
        ln -s /etc/rancher/k3s/k3s.yaml $KUBE_PATH/config
        chown -R k3s:users $KUBE_PATH
        chmod 750 $KUBE_PATH/config
      fi
    '';
  };
}
