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
    # my hm-modules config
    roles = {
      work = true;
    };
    # hm config
    home = {
      username = "groemmer";
      homeDirectory = lib.mkDefault "/Users/${config.home.username}";
      stateVersion = lib.mkDefault "22.05";
    };
  };
}
