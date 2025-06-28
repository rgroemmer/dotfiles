{
  config,
  pkgs,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.hyprlock;
    settings = {
      general = {
        disable_loading_bar = true;
      };
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
      };
      listener = [
        # autolock
        {
          timeout = 1200;
          on-timeout = "hyprlock";
        }
        # display off
        {
          timeout = 9000;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
