{lib, ...}: {
  imports = [
    ./common

    ./cli
    ./desktop
  ];

  # FIXME:
  # - Only set hyprland config with nix
  # - Disable hyprlock & hyprpaper for work
  # - Move sops key creation & ssh_config from nix to HM
  # - Configure atuin correctly, add docs
  # - Make NixGL configurable, add docs
  # - Move font-config to HM

  # NOTE: Additionally
  # - Create window-rules
  # - Check dotfiles structure
  # - Move most of nixOS to HM

  config = {
    # my hm-modules config
    roles = {
      workdevice = true;

      useNixGL = true;

      desktop = {
        hyprland = {
          enable = true;
          configOnly = true;
          hyprlock = false;
          hyprpaper = false;
        };
      };
    };
    # hm config
    home = {
      username = "raphael.groemmer@stackit.cloud";
      homeDirectory = lib.mkDefault "/home/Raphael.Groemmer@stackit.cloud";
      stateVersion = lib.mkDefault "22.05";
    };
  };
}
