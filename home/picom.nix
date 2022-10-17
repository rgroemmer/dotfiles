{ pkgs, ... }:

{
  services.picom = {
    enable = true;

    shadow = true;
    shadowOffsets = [ (-7) (-7) ];
    shadowOpacity = 0.7;
 };
}

