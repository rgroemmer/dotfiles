{ pkgs, config, ... }:
{
  programs.alacritty = {
    enable = true;

    catppuccin.enable = true;

    settings = {
      shell.program = "zsh";
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

      font =
        let
          fontname = "CaskaydiaCove Nerd Font";
        in
        {
          normal = {
            family = fontname;
            style = "Regular";
          };
          bold = {
            family = fontname;
            style = "SemiBold";
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
