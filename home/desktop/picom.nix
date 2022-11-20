{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    vSync = true;

    inactiveOpacity = 0.95;
    fade = true;
    fadeDelta = 3;
    
    opacityRules = [
    ];
    backend = "glx";
 };
}

