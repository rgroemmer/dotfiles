{
  pkgs,
  lib,
  config,
  ...
}: {
  #options.roles.work.enable = mkEnableOption "work";
  config = lib.mkIf config.roles.work {
    home.packages = with pkgs; [
      # CLI
      stackit-cli
      openstackclient

      # Tools
      terraform
      ansible
      vault-bin
    ];
  };
}
