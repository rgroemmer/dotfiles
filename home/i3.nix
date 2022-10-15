{ pkgs, lib, ... }: {
  services.betterlockscreen = {
    enable = true;
    inactiveInterval = 10; # auto locks
  };

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;

      config = null;
      extraConfig = lib.strings.fileContents ../config/i3.config;
    };
  };
}
