{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.system.modules.k3s;
  getConfig = pkgs.writeShellScriptBin "getConfig" ''
    #!/usr/bin/env bash

    mkdir -p ~/.kube/
    sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
    sudo chown k3s:users ~/.kube/config
  '';
in {
  imports = [
    ./service.nix
    ./network.nix
  ];

  options.system.modules.k3s = mkEnableOption "Enable k3s cluster configuration.";

  config = mkIf cfg {
    environment = {
      shellAliases = {
        k = "kubectl";
      };
      systemPackages = with pkgs; [
        getConfig
        kubectl

        # Storage
        zfs
      ];
    };

    # TODO: verify
    # Link zfs to be in PATH for openebs-provisioner
    system.activationScripts.link-zsh = lib.stringAfter ["var"] ''
      ln -s /run/current-system/sw/bin/zfs /usr/bin/zfs
    '';
  };
}
