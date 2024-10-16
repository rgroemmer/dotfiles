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
    ../../home-manager
    ../../home-manager/cli
    ../../home-manager/desktop
  ];

  config = {
    home = {
      username = "rap";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      inherit (outputs) stateVersion;
    };
  };
}
