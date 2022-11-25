{ pkgs, lib, ... }: {
  home.file = let 
    destination = ".config/rofi";
  in {
    "${destination}/launcher.rasi" = {
      source = ../config/rofi/launcher.rasi;
    };
  
    "${destination}/confirm.rasi" = {
      source = ../config/rofi/confirm.rasi;
    };
  
    "${destination}/powermenu.rasi" = {
      source = ../config/rofi/powermenu.rasi;
    };

    "${destination}/message.rasi" = {
      source = ../config/rofi/message.rasi;
    };

    "${destination}/colors.rasi" = {
      source = ../config/rofi/colors.rasi;
    };

    "${destination}/styles.rasi" = {
      source = ../config/rofi/styles.rasi;
    };
 };
 
  programs.rofi = {
    enable = true;
    cycle = true;
    font = "Source Sans Pro 10";

    extraConfig = {
      kb-remove-to-eol = "";
      kb-accept-entry = "Return";
      kb-row-up = "Control+k";
      kb-row-down = "Control+j";
    };
  };
}
