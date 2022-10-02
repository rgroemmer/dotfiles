{ config, pkgs, ... }:

{
	# Tell Home-Manager what home to manage
	home.username = "rap";
	home.homeDirectory = "/home/rap";

	# State version
	home.stateVersion = "22.05";

	# Let home-manager manage itself
	programs.home-manager.enable = true;


	# Zsh config
	home.file.".zshrc" = {
		source = ./dotfiles/.zshrc;
	};
	home.file.".p10k.zsh" = {
		source = ./dotfiles/.p10k.zsh;
	};
	home.file.".zsh_additions" = {
		source = ./dotfiles/.zsh_additions;
	};

  programs.alacritty = {
    enable = true;
    settings = { 
      font.normal.family = "CaskaydiaCove Nerd Font";
      font.size = 11;

      window.dimensions.columns = 170;
      window.dimensions.lines = 60;
      colors.primary.foreground = "#D0D0D0";
      colors.primary.background = "#202225";

      colors.normal.black   = "#3A3E45";
      colors.normal.red     = "#d41919";
      colors.normal.green   = "#33d17a";
      colors.normal.yellow  = "#ffbe6f";
      colors.normal.blue    = "#357af0";
      colors.normal.magenta = "#2ebf5d";
      colors.normal.cyan    = "#49aee6";
      colors.normal.white   = "#4f4f4f";

      colors.bright.black   = "#828282";
      colors.bright.red     = "#ff0000";
      colors.bright.green   = "#47d4b9";
      colors.bright.yellow  = "#ff7e00";
      colors.bright.blue    = "#005eff";
      colors.bright.magenta = "#ff0053";
      colors.bright.cyan    = "#00a4ff";
      colors.bright.white   = "#d0d0d0";
      
    };
  };

  programs.zsh.ohMyZsh = {
      enable = true;
      plugins = [ "git" "kubectl" "autojump" ];
  };

    programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}