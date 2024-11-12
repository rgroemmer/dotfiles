{
  outputs,
  lib,
  config,
  ...
}: {
  imports = [
    ../../../home-manager
    ../../../home-manager/cli
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

  config = {
    home = {
      username = "groemmer";
      homeDirectory = lib.mkDefault "/Users/${config.home.username}";
      inherit (outputs) stateVersion;
    };
  };
}
