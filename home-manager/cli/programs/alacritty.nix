{config, ...}: {
  catppuccin.alacritty.enable = true;
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell.program = "zsh";
      env.TERM = "xterm-256color";

      selection = {
        save_to_clipboard = true;
      };
      window = {
        padding = {
          x = 5;
          y = 5;
        };
      };

      font = let
        fontname = "CaskaydiaCove Nerd Font";
      in {
        normal = {
          family = fontname;
          style =
            if config.roles.work
            then "Regular"
            else "SemiBold";
        };
        bold = {
          family = fontname;
          style =
            if config.roles.work
            then "SemiBold"
            else "Bold";
        };
        italic = {
          family = fontname;
          style = "Italic";
        };
        size = 12;
        offset.y = 3;
      };

      mouse.bindings = [
        {
          mouse = "Right";
          action = "Paste";
        }
      ];
    };
  };
}
