{ pkgs, config, ... }: {
  programs.alacritty = {
    enable = true;

    settings = {
      shell.program = "zsh";
      env.TERM = "xterm-256color";

      selection = { save_to_clipboard = true; };
      window = {
        padding = {
          x = 5;
          y = 5;
        };
      };

      font = let fontname = "Hurmit Nerd Font";
      in {
        normal = {
          family = fontname;
          style = "SemiBold";
        };
        bold = {
          family = fontname;
          style = "Bold";
        };
        italic = {
          family = fontname;
          style = "Italic";
        };
        size = 12;
      };

      mouse.bindings = [{
        mouse = "Right";
        action = "Paste";
      }];

      colors = {
        primary = {
          background = "#${config.colorscheme.colors.base00}";
          foreground = "#${config.colorscheme.colors.base05}";
          dim_foreground = "#${config.colorscheme.colors.base05}";
          bright_foreground = "#${config.colorscheme.colors.base05}";
        };
        cursor = {
          text = "#${config.colorscheme.colors.base00}";
          cursor = "#${config.colorscheme.colors.base06}";
        };
        vi_mode_cursor = {
          text = "#${config.colorscheme.colors.base00}";
          cursor = "#${config.colorscheme.colors.base07}";
        };
        search = {
          matches = {
            foreground = "#${config.colorscheme.colors.base00}";
            background = "#A5ADCE";
          };
          focused_match = {
            foreground = "#${config.colorscheme.colors.base00}";
            background = "#${config.colorscheme.colors.base0B}";
          };
        };
        hints = {
          start = {
            foreground = "#${config.colorscheme.colors.base00}";
            background = "#${config.colorscheme.colors.base0A}";
          };
          end = {
            foreground = "#${config.colorscheme.colors.base00}";
            background = "#A5ADCE";
          };
        };
        selection = {
          text = "#${config.colorscheme.colors.base00}";
          background = "#${config.colorscheme.colors.base06}";
        };
        normal = {
          black = "#51576D";
          red = "#${config.colorscheme.colors.base08}";
          green = "#${config.colorscheme.colors.base0B}";
          yellow = "#${config.colorscheme.colors.base0A}";
          blue = "#${config.colorscheme.colors.base0D}";
          magenta = "#F4B8E4";
          cyan = "#${config.colorscheme.colors.base0C}";
          white = "#B5BFE2";
        };
        bright = {
          black = "#626880";
          red = "#${config.colorscheme.colors.base08}";
          green = "#${config.colorscheme.colors.base0B}";
          yellow = "#${config.colorscheme.colors.base0A}";
          blue = "#${config.colorscheme.colors.base0D}";
          magenta = "#F4B8E4";
          cyan = "#${config.colorscheme.colors.base0C}";
          white = "#A5ADCE";
        };
        dim = {
          black = "#51576D";
          red = "#${config.colorscheme.colors.base08}";
          green = "#${config.colorscheme.colors.base0B}";
          yellow = "#${config.colorscheme.colors.base0A}";
          blue = "#${config.colorscheme.colors.base0D}";
          magenta = "#F4B8E4";
          cyan = "#${config.colorscheme.colors.base0C}";
          white = "#B5BFE2";
        };
        indexed_colors = [
          {
            index = 16;
            color = "#EF9F76";
          }
          {
            index = 17;
            color = "#${config.colorscheme.colors.base06}";
          }
        ];
      };
    };
  };
}
