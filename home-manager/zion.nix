{
  lib,
  config,
  ...
}: {
  imports = [
    ./common

    ./cli
    ./desktop
  ];

  config = {
    # my own hm-modules config
    roles = {
    };
    # hm config
    home = {
      username = "rap";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "22.05";
    };
  };
}
