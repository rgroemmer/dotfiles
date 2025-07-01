{pkgs, ...}: {
  wayland.windowManager.hyprland.extraConfig = ''
    bind = SUPER SHIFT,O, movetoworkspace, special
    bind = SUPER+SHIFT,F, fullscreen
    bind = SUPER+SHIFT,H, movewindow,l
    bind = SUPER+SHIFT,J, movewindow, d
    bind = SUPER+SHIFT,K, movewindow, u
    bind = SUPER+SHIFT,L, movewindow, r
    bind = SUPER+SHIFT,S, movetoworkspace, 4
    bind = SUPER,1, workspace, 1
    bind = SUPER,2, workspace, 2
    bind = SUPER,3, workspace, 3
    bind = SUPER,4, workspace, 4
    bind = SUPER,5, workspace, 5
    bind = SUPER,6, workspace, 6
    bind = SUPER,7, workspace, 7
    bind = SUPER,8, workspace, 8
    bind = SUPER,9, workspace, 9
    bind = SUPER,F, fullscreen, 1
    bind = SUPER,O, togglespecialworkspace,
    bind = SUPER,Q, killactive
    bind = SUPER,R, togglesplit,
    bind = SUPER,RETURN, exec, alacritty
    bind = SUPER,S, movetoworkspace, 2
    bind = SUPER,SPACE, exec, export LC_ALL=C && ${pkgs.tofi}/bin/tofi-drun | xargs hyprctl dispatch exec --
    bind = SUPER,p, exec, ${pkgs.wlogout}/bin/wlogout
    bind = SUPER,T, togglefloating,
    bind = SUPER,h, movefocus, l
    bind = SUPER,j, movefocus, d
    bind = SUPER,k, movefocus, u
    bind = SUPER,l, movefocus, r

    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow
  '';
}
