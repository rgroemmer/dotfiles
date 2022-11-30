{ pkgs, ... }: {

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window = {
        opacity = 1;
        dynamic_title = true;
        dynamic_padding = true;
        decorations = "full";
        dimensions = {
          lines = 50;
          columns = 100;
        };
        padding = {
          x = 5;
          y = 5;
        };
      };

      font = let fontname = "CaskaydiaCove Nerd Font Mono"; in
        {
          normal = { family = fontname; style = "Regular"; };
          bold = { family = fontname; style = "SemiBold"; };
          italic = { family = fontname; style = "Light"; };
          size = 10.5;
          apple_font_smoothing = true;
        };

      colors = {
        primary = {
          foreground = "#D0D0D0";
          background = "#202225";
        };
        normal = {
          black = "#3A3E45";
          red="#e06c75";
          green = "#33d17a";
          yellow = "#ffbe6f";
          blue = "#357af0";
          magenta = "#2ebf5d";
          cyan = "#49aee6";
          white = "#4f4f4f";
        };
        bright = {
          black = "#828282";
          red="#e06c75";
          green = "#47d4b9";
          yellow = "#ff7e00";
          blue = "#005eff";
          magenta = "#ff0053";
          cyan = "#00a4ff";
          white = "#d0d0d0";
        };
      };
    };
  };
}
