let
  displays = import ./monitors.nix;
  one-piece-logo = "~/.config/wallpapers/one-piece-logo.jpg";
  supersaiyan = "~/.config/wallpapers/gohan-supersaiyan.png";
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
        supersaiyan
      ];
      wallpaper = [
        "${displays.primary.output},contain:${one-piece-logo}"
        "${displays.left.output},contain:${supersaiyan}"
      ];
    };
  };
}
