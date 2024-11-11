{
  lib,
  config,
  ...
}: {
  imports = [
    ./common

    ./cli
  ];

  config = {
    # my hm-modules config
    roles = {
      work = true;
    };
    # hm config
    home = {
      username = "rap";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "22.05";
    };
  };
}
