{ config, pkgs, lib, ... }: {
  home.file.polybar = {
    executable = true;
    target = ".config/polybar.sh";
    text = ''
      #!/bin/env sh

      pkill polybar

      sleep 1;

      polybar i3wmthemer_bar &
    '';
  };

  programs.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
    };
    config = ../config/polybar.config;

    # i3 handles launching polybar
    # at the time nix launches polybar
    # there is no information about monitors available
    script = "exit 0";
  };
}