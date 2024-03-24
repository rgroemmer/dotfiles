{ lib, ... }:
let
  # helper factory function, it takes the rules an add it to the attrs
  # inherit is equal to: rules = rules
  rule = rules: attrs: attrs // { inherit rules; };
in {
  # windowRules is an array of attrs which have a windowSelector (like class, title, etc) and a rules field
  wayland.windowManager.hyprland.windowRules = let
    alacritty.class = [ "Alacritty" ];
    firefox.class = [ "firefox" ];
    keepassxc.class = [ ".*keepassxc.*" ];
    nextcloud.class = [ ".*nextcloud.*" ];
  in lib.concatLists [[
    (rule [ "workspace 1" ] alacritty)
    (rule [ "workspace 4" ] firefox)
    (rule [ "workspace 7" ] keepassxc)
    (rule [ "float" ] nextcloud)
    (rule [ "opacity 0.8" ] nextcloud)
  ]];
}

