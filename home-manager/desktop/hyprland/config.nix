{pkgs, ...}: let
  displays = {
    left = {
      output = "HDMI-A-1";
      settings = "1920x1080@144, 0x180, 1";
    };
    primary = {
      output = "DP-2";
      settings = "2560x1440@240, 1920x0, 1";
    };
    right = {
      output = "DP-1";
      settings = "1920x1080@144, 4480x180, 1";
    };
  };
in {
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 8;
      gaps_out = 10;
      border_size = 3;
    };

    windowrule = [
      "float, steam"
      "size 70% 70%, steam"
      "center, steam"

      "float, com.nextcloud.desktopclient.nextcloud"
      "size 20% 50%, com.nextcloud.desktopclient.nextcloud"
      "move 79% 3%, com.nextcloud.desktopclient.nextcloud"
    ];

    input = {
      kb_layout = "eu";
      repeat_rate = 35;
      repeat_delay = 250;
      accel_profile = "flat";
      sensitivity = 1; # -1.0 - 1.0, 0 means no modification.
    };

    exec-once = [
      # move alacritty to special workspace silently
      "[ workspace special silent ] ${pkgs.alacritty}/bin/alacritty -t scratchy"
      "${pkgs.firefox-devedition}/bin/firefox-devedition"
      "${pkgs.blueman}/bin/blueman-applet"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
    ];

    monitor = with displays; [
      "${left.output}, ${left.settings}"
      "${primary.output}, ${primary.settings}"
      "${right.output}, ${right.settings}"
    ];

    workspace = with displays; [
      "name:1, monitor:${primary.output}"
      "name:2, monitor:${primary.output}"
      "name:3, monitor:${primary.output}"
      "name:4, monitor:${left.output}"
      "name:5, monitor:${left.output}"
      "name:6, monitor:${right.output}"
      "name:7, monitor:${right.output}"
      "name:8, monitor:${right.output}"
      "name:9, monitor:${right.output}"
    ];

    dwindle = {
      preserve_split = "yes";
      special_scale_factor = 0.8;
    };

    decoration = {
      rounding = 5;
    };
  };
}
