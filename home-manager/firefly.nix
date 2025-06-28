{lib, ...}: {
  imports = [
    ./common

    ./cli
    ./desktop
  ];

  # TODO:!
  # 1. Reinstall workdevice
  # 2. Install hyprland from PPA
  #   2.1 Try out hyprlock / hyprpaper or swaylock
  # 3. Write docs / steps
  # 4. Install lix
  # 5. HM switch

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
