{
  lib,
  config,
  ...
}: {
  imports = [
    ./global
  ];
  # host specific configuration
  config = {
    home = {
      username = "rap";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "22.05";
    };
  };
}
