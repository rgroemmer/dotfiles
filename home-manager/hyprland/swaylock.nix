{ pkgs, config, ... }: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      show-failed-attempts = true;
      screenshots = true;
      clock = true;

      indicator = true;
      indicator-radius = 350;
      indicator-thickness = 5;

      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
      fade-in = 0.2;
    };
  };

  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
    ];
  };
}

