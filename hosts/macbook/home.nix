{
  outputs,
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  /*
    This is the entrypoint for home-manager
    config is the attrs to configure all modules for HM
  */

  imports = [ ../../home-manager ];

  config = {
    home = {
      username = "groemmer";
      homeDirectory = lib.mkDefault "/Users/${config.home.username}";
      stateVersion = outputs.stateVersion;
    };
  };
}
