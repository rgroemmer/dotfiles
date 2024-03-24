{ pkgs, ... }: {
  nixpkgs.config.joypixels.acceptLicense = true;
  fonts = {
    enableDefaultPackages = false;
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "CascadiaCode" "Hermit" ]; })
      fontconfig
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
}

