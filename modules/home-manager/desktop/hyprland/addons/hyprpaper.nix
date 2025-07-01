{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  displays = import ../config/displays.nix {inherit (config.roles) work;};
  path = "~/.config/wallpapers";

  shuffle-wallpaper = pkgs.writeShellScriptBin "shuffle-wallpaper" ''
    #!/usr/bin/env bash

    SHUFFLE1="$(ls ${path} | shuf -n1)"
    hyprctl hyprpaper preload "${path}/$SHUFFLE1"
    hyprctl hyprpaper wallpaper "${displays.primary.output},${path}/$SHUFFLE1"
    SHUFFLE2="$(ls ${path} | grep -v "$SHUFFLE1" | shuf -n1)"
    hyprctl hyprpaper preload "${path}/$SHUFFLE2"
    hyprctl hyprpaper wallpaper "${displays.left.output},${path}/$SHUFFLE2"

    hyprctl hyprpaper unload unused

  '';
  cfg = config.roles.desktop.hyprland.hyprlock;
in {
  config = mkIf cfg {
    home.file.".config/wallpapers" = {
      source = ./wallpapers;
      recursive = true;
    };
    home.packages = [shuffle-wallpaper];

    services.hyprpaper = {
      enable = true;
      package = pkgs.hyprlock;
      settings = {
        splash = false;
      };
    };
  };
}
