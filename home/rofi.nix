{ pkgs, ... }: {

  

  programs.rofi = {
    enable = true;
    cycle = true;
    font = "Source Sans Pro 10";

    theme = ../config/rofi.config;
    extraConfig = {
      kb-remove-to-eol = "";
      kb-accept-entry = "Return";
      kb-row-up = "Control+k";
      kb-row-down = "Control+j";
    };
  };
}
