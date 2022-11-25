{ pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      # additional envs
      borgUser = "borg";
      borgServer = "192.168.55.200";
      borgBackupPath = "/backups/manjaro";
      borg = "ssh://$borgUser@$borgServer$borgBackupPath";
    };

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 20000;
      size = 20000;
      share = true;
    };

    initExtra = ''
      # additional config
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      source ~/.config/zsh/plugins/p10k.zsh

      # Path config
      export PATH=$PATH:~/bin
      export PATH=$PATH:/home/rap/Projects/SKE/azure/ske-bash-utils
      export PATH="$PATH:$HOME/.krew/bin"

      # gardenctl config
      [ -n "$GCTL_SESSION_ID" ] || [ -n "$TERM_SESSION_ID" ] || export GCTL_SESSION_ID=$(uuidgen)

      # kubernetes functions
      seld() {
          BASE_PATH=~/Downloads
          YAMLS=$(ls --no-icons $BASE_PATH | awk -F/ '{ print $NF }')
          KUBECONFIG=$(echo $YAMLS | fzf)
          export KUBECONFIG=$BASE_PATH/$KUBECONFIG
      }

      selc() {
          BASE_PATH=~/configs/kubeconfigs
          YAMLS=$(ls --no-icons $BASE_PATH/*yaml | awk -F/ '{ print $NF }')
          KUBECONFIG=$(echo $YAMLS | fzf)
          export KUBECONFIG=$BASE_PATH/$KUBECONFIG
      }

      # keyboard flash
      qmkflash() {
          cd ~/Projects/RAPSN/upstream/qmk_firmware/keyboards/sofle_choc/keymaps/rap
          mv ~/Downloads/sofle_rev1_layout_mine.json rapsn_neo.json
          qmk json2c -o keymap-rap.c rapsn_neo.json
          qmk flash -kb sofle_choc -km rap
      }

      # proxy
      proxmox() {
        ssh -N babo -D 1337 -i ~/.ssh/devops 
      }

      boobs() {
        firefox  --safe-mode --new-window "https://screen.internal.ske.eu01.stackit.cloud/?room=boobs" 
      }

      # nixos rebuil
      nos() {
        sudo nixos-rebuild switch --flake '/home/rap/Projects/Rapsn/upstream/nixos#rapos'
        i3-msg reload
        bash ~/.config/polybar/start.sh &>/dev/null
      }
    '';

    shellAliases = {
      # Overwrites
      cat = "bat";
      ls = "exa --icons";
      ll = "exa --icons -la";
      vim = "nvim";
      j = "z";

      # Shortcuts
      clr = "clear";
      pbcopy = "xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard -o";

      tf = "terraform";
      g = "gardenctl";
      g2 = "gardenctlv2";

      k = "kubectl";
      kns = "switch ns";
      
      pui = "pulumi";
      o = "openstack";
      selg = ". selg";

      clean = "nix-collect-garbage -d && nix-store --gc && nix-store --verify --check-contents --repair";

      # esp-suite
      esp-export = "source ~/esp/esp-idf/export.sh";
      esp-build = "idf.py -p /dev/ttyUSB0 -b 115200 build";
      esp-flash = "idf.py -p /dev/ttyUSB0 -b 115200 flash";
      esp-monitor = "idf.py -p /dev/ttyUSB0 -b 115200 monitor";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "kubectl"
      ];
    };
    plugins = with pkgs; [
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-autopair";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
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
        src = ../config/p10k.config;
      }
    ];
  };
}
