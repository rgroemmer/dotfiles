{pkgs, ...}: let
  displays = import ./displays.nix;
in {
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 8;
      gaps_out = 10;
      border_size = 3;
    };

    windowrule = [
      "float, class:steam"
      "size 70% 70%, class:steam"
      "center, class:steam"

      "float, class:com.nextcloud.desktopclient.nextcloud"
      "size 20% 50%, class:com.nextcloud.desktopclient.nextcloud"
      "move 79% 3%, class:com.nextcloud.desktopclient.nextcloud"
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

      # set wallpapers randomly
      "sleep 1 && /home/rap/.nix-profile/bin/shuffle-wallpaper"
    ];

    monitor = with displays; [
      "${left.output}, ${left.settings}"
      "${primary.output}, ${primary.settings}"
    ];

    workspace = with displays; [
      "name:1, monitor:${primary.output}"
      "name:2, monitor:${primary.output}"
      "name:3, monitor:${primary.output}"
      "name:4, monitor:${primary.output}"
      "name:5, monitor:${left.output}"
      "name:6, monitor:${left.output}"
      "name:7, monitor:${left.output}"
      "name:8, monitor:${left.output}"
      "name:9, monitor:${left.output}"
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
