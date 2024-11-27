{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.system.modules.desktop;
in
  with lib; {
    config = mkIf cfg {
      nixpkgs.config.joypixels.acceptLicense = true;
      fonts = {
        enableDefaultPackages = false;
        fontDir.enable = true;
        packages = with pkgs; [
          (nerdfonts.override {fonts = ["CascadiaCode"];})
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
