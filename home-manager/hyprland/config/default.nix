{ pkgs, config, lib, ... }:
let
  displays = {
    left = "HDMI-A-1";
    primary = "DP-2";
    right = "DP-1";
  };
in {
  imports = [ ./keybindings.nix ./windowrules.nix ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    reloadConfig = true;
    systemdIntegration = true;
    recommendedEnvironment = true;
    xwayland.enable = true;

    config = {
      input = {
        kb_layout = "de";
        repeat_rate = 35;
        repeat_delay = 250;
        accel_profile = "flat";
        sensitivity = 1; # -1.0 - 1.0, 0 means no modification.
      };

      workspace = [
        "name:1, monitor:${displays.primary}"
        "name:2, monitor:${displays.primary}"
        "name:3, monitor:${displays.primary}"
        "name:4, monitor:${displays.left}"
        "name:5, monitor:${displays.left}"
        "name:6, monitor:${displays.right}"
        "name:7, monitor:${displays.right}"
        "name:8, monitor:${displays.right}"
        "name:9, monitor:${displays.right}"
      ];

      monitor = [
        "${displays.left}, 1920x1080@144, 0x180,1"
        "${displays.primary}, 2560x1440@240, 1920x0, 1"
        "${displays.right}, 1920x1080@144, 4480x180, 1"
      ];

      exec_once = [
        # move alacritty to special workspace silently
        "[ workspace special silent ] ${pkgs.alacritty}/bin/alacritty -t scratchy"
        "${pkgs.firefox}/bin/firefox"
        "${pkgs.keepassxc}/bin/keepassxc"
        "${pkgs.blueman}/bin/blueman-applet"
      ];

      dwindle = {
        preserve_split = "yes";
        special_scale_factor = 0.8;
      };

      general = {
        gaps_in = 8;
        gaps_out = 10;
        border_size = 3;
      };
      misc = { disable_autoreload = true; };
      decoration = { rounding = 5; };
    };
  };
}

