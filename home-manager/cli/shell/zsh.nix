{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.catppuccin.enable = true;
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";

    antidote = {
      enable = true;
      plugins = [
        "romkatv/powerlevel10k"
        "hlissner/zsh-autopair"
        "Aloxaf/fzf-tab"
        "ohmyzsh/ohmyzsh path:plugins/git"
        "ohmyzsh/ohmyzsh path:plugins/history-substring-search"
        "ohmyzsh/ohmyzsh path:plugins/kubectl"
      ];
    };

    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";

      # pinentry for sign commits with gpg
      GPG_TTY = "$(tty)";
      # gardenctl session-id
      GCTL_SESSION_ID = "$(uuidgen)";

      # disable highlight of history-substring-search
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND = "";
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
      # p10k
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      source ~/.config/zsh/.p10k.zsh

      # gardenctl config
      if command -v gardenctl &> /dev/null
      then
        source <(gardenctl rc zsh -p gctl)
      fi

      # helper functions
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
  };
  home.file.".config/zsh/.p10k.zsh".source = ./p10k.config;
}
