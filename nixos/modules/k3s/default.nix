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

    # Link zfs to be in PATH for openebs-provisioner
    system.activationScripts.link-zsh = lib.stringAfter ["var"] ''
      ln -sf /run/current-system/sw/bin/zfs /usr/bin/zfs
    '';

    # Enable smartmon to collect disk health data
    services.smard = {
      enable = true;
      autodetect = true;
      # SMART Automatic Offline Testing on startup, and schedules short self-tests daily, and long self-tests weekly.
      defaults.monitored = "-a -o on -s (S/../.././02|L/../../7/04)";
    };

    # Import encrypted ZFS-Pool at startup
    systemd.services.zfs-import = {
      description = "Import ZFS Pool with Encryption";
      wants = ["zfs.target"];
      before = ["zfs.target"];
      after = ["local-fs.target"];
      serviceConfig = {
        ExecStart = "/bin/sh -c 'cat /tmp/zfs-encryption-key | /run/current-system/sw/bin/zfs load-key kubex-main'";
        ExecStartPre = "/run/current-system/sw/bin/zpool import -a";
        Type = "oneshot";
        RemainAfterExit = true;
      };
      wantedBy = ["multi-user.target"];
    };
  };
}
