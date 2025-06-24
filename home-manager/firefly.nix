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
      username = "raphael.groemmer@stackit.cloud";
      homeDirectory = lib.mkDefault "/home/Raphael.Groemmer@stackit.cloud";
      stateVersion = lib.mkDefault "22.05";
    };
  };
}
