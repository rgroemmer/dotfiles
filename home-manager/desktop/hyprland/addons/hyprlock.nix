{
  programs.hyprlock = {
    enable = true;
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
