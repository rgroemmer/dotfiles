{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    vSync = true;

    inactiveOpacity = 0.95;
    fade = true;
    fadeDelta = 3;
    
    opacityRules = [
      # always make terminals slightly transparent
      "95:class_g = 'Alacritty' && focused"
      "90:class_g = 'Alacritty' && !focused"
    ];
    backend = "glx";
 };
}

