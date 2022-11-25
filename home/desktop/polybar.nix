{ config, pkgs, lib, ... }: {
  home.file.polybar = {
    executable = true;
    target = ".config/polybar/start.sh";
    text = ''
      # Terminate already running bar instances
      pkill polybar

      # Wait until the processes have been shut down
      while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

      # Launch the bar
      for m in $(polybar --list-monitors | cut -d":" -f1); do
        MONITOR=$m polybar &
      done
    '';
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
    };
    config = ../config/polybar.ini;

    # i3 handles launching polybar
    # at the time nix launches polybar
    # there is no information about monitors available
    script = "exit 0";
  };
}