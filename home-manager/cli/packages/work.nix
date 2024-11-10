{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.roles.work;
in
  with lib; {
    options.roles.work = {
      enable = mkEnableOption "work";
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        # CLIs
        stackit-cli
        terraform

        # Tools
        vault-bin
      ];
    };
  }
