{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";

    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";

      # pinentry for sign commits with gpg
      GPG_TTY = "$(tty)";

      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = "true";

      GCTL_SESSION_ID = "$(uuidgen)";
    };

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 1000000000;
      size = 1000000000;
      share = true;
    };

    initExtra = ''
      source ~/.config/zsh/plugins/p10k.zsh

      # additional path config
      export PATH=$PATH:~/bin
      export PATH="$PATH:$HOME/.krew/bin"
      export PATH="$PATH:~/.docker/bin"

      if command -v gardenctl &> /dev/null
      then
        source <(gardenctl rc zsh -p gctl)
      fi

      selc() {
        BASE_PATH=~/.config/kubeconfig
        YAMLS=$(find $BASE_PATH -name '*.yaml' | awk -F/ '{ print $NF }')
        KUBECONFIG=$(echo $YAMLS | fzf)
        export KUBECONFIG=$BASE_PATH/$KUBECONFIG
      }
    '';

    shellAliases = {
      # Overwrites
      cat = "bat";
      ls = "exa --icons";
      ll = "exa --icons -la";
      j = "z";
      n = "nix-shell -p";

      # Shortcuts
      clr = "clear";
      tf = "terraform";

      g = "gardenctl";
      gtcp = "gardenctl target control-plane";
      gos = "eval $(gardenctl provider-env zsh)";
      o = "openstack";

      k = "kubectl";
      kk = "k9s";
      clean = "nix-collect-garbage -d && nix-store --gc && nix-store --verify --check-contents --repair";
    };

    plugins = with pkgs; [
      {
        name = "zsh-autopair";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "v1.0";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
        file = "autopair.zsh";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = "${zsh-nix-shell}/share/zsh-nix-shell";
      }
      {
        name = "powerlevel10k";
        file = "powerlevel10k.zsh-theme";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
      {
        name = "p10k.zsh";
        file = "p10k.zsh";
        src = ./p10k.config;
      }
    ];
  };
}
