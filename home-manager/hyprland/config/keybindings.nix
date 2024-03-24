{ pkgs, config, ... }: {
  wayland.windowManager.hyprland.keyBinds = {
    bind = {
      "SUPER,RETURN" = "exec, alacritty";
      #"SUPER,E"       = "exec, $fileManager";
      "SUPER,SPACE" = "exec, ${pkgs.wofi}/bin/wofi --show drun";

      "SUPER,Q" = "killactive";
      "SUPER,T" = "togglefloating,";
      "SUPER,R" = "togglesplit,";
      "SUPER,F" = "fullscreen, 1";
      "SUPER+SHIFT,F" = "fullscreen";

      # Workspaces
      "SUPER,1" = "workspace, 1";
      "SUPER,2" = "workspace, 2";
      "SUPER,3" = "workspace, 3";
      "SUPER,4" = "workspace, 4";
      "SUPER,5" = "workspace, 5";
      "SUPER,6" = "workspace, 6";
      "SUPER,7" = "workspace, 7";
      "SUPER,8" = "workspace, 8";
      "SUPER,9" = "workspace, 9";

      # Movement
      "SUPER,h" = "movefocus, l";
      "SUPER,j" = "movefocus, d";
      "SUPER,k" = "movefocus, u";
      "SUPER,l" = "movefocus, r";

      "SUPER+SHIFT,H" = "movewindow,l";
      "SUPER+SHIFT,J" = "movewindow, d";
      "SUPER+SHIFT,K" = "movewindow, u";
      "SUPER+SHIFT,L" = "movewindow, r";

      # Special
      "SUPER,S" = "movetoworkspace, 2";
      "SUPER+SHIFT,S" = "movetoworkspace, 4";

      # Scratchy
      "SUPER,O" = "togglespecialworkspace,";
      "SUPER SHIFT,O" = "movetoworkspace, special";
    };
    bindm = {
      # Drag&Drop with left mouse, resize with right click
      "SUPER, mouse:272" = "movewindow";
      "SUPER, mouse:273" = "resizewindow";
    };
  };
}

