let
  displays = import ./monitors.nix;
  one-piece-logo = "one-piece-logo.jpg";
  anime-city = "anime-city.jpg";
in {
  home.file.".config/wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
        one-piece-logo
        anime-city
      ];
      wallpaper = [
        "${displays.primary.output},${one-piece-logo}"
        "${displays.left.output},${anime-city}"
      ];
    };
  };
}
