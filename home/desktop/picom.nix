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
      "90:class_g = 'Alacritty' && !focused"
      "80:class_g = 'Mumble.*'"
    ];
    backend = "glx";
 };
}

