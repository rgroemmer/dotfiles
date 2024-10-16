{
  outputs,
  lib,
  config,
  ...
}:
{
  /*
    This is the entrypoint for home-manager
    config is the attrs to configure all modules for HM
  */
  imports = [
    ../../../home-manager
    ../../../home-manager/cli
  ];

  config = {
    home = {
      username = "groemmer";
      homeDirectory = lib.mkDefault "/Users/${config.home.username}";
      inherit (outputs) stateVersion;
    };
  };
}
