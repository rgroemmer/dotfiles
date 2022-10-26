{ pkgs, ... }: 
let 
  destPath = ".config/rofi";
in {
  home.file."${destPath}/launcher.rasi" = {
    source = ../config/rofi/launcher.rasi;
  };

  home.file."${destPath}/image.png" = {
    source = ../config/rofi/image.png;
  };

  home.file."${destPath}/powermenu.rasi" = {
    source = ../config/rofi/powermenu.rasi;
  };

  home.file."${destPath}/powermenu.sh" = {
    source = ../config/rofi/powermenu.sh;
  };

  home.file.".local/share/fonts/Icomoon-Feather.ttf" = {
    source = ../config/rofi/Icomoon-Feather.ttf;
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
