let
  displays = import ./monitors.nix;
  one-piece = "~/Downloads/11020521.jpg";
  gear5-2 = "~/Downloads/11020389.jpg";
  skyline-minimal = "~/Downloads/1303828.jpg";
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
        one-piece
        gear5-2
        skyline-minimal
      ];
      wallpaper = [
        "${displays.primary.output},${one-piece}"
        "${displays.left.output},${gear5-2}"
      ];
    };
  };
}
