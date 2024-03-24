{ inputs, outputs, pkgs, lib, config, ... }: {
  /*
    This is the entrypoint for home-manager
    Config is the attrs to configure all modules for HM
  */
  imports = [ ../../home-manager ];

  config = {
    home = {
      username = "rap";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = outputs.stateVersion;
    };
    colorscheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  };
}

