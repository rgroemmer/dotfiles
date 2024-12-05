{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.system.modules.desktop;
in {
  config = mkIf cfg {
    nixpkgs.config.joypixels.acceptLicense = true;
    fonts = {
      enableDefaultPackages = false;
      fontDir.enable = true;
      packages = with pkgs; [
        nerd-fonts.caskaydia-cove
        fontconfig
        noto-fonts-emoji
      ];

      fontconfig = {
        antialias = true;
        enable = true;
        hinting = {
          autohint = true;
          enable = true;
          style = "slight";
        };
        subpixel = {
          rgba = "rgb";
          lcdfilter = "light";
        };
      };
    };
  };
}
