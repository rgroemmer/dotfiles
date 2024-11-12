{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./k9s.nix
  ];

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
