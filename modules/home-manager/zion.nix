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
    roles = {
      desktop = {
        hyprland = {
          enable = true;
          hyprlock = true;
          hyprpaper = true;
          monitors = [
            {
              ID = "DP-2";
              settings = "highres, 0x0, 1";
            }
            {
              ID = "DP-1";
              settings = "highres, 2560x0, 1.5";
            }
          ];
        };
      };
    };
    # hm config
    home = {
      username = "rap";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "22.05";
    };
  };
}
