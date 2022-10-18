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

      # add ske-tools to path
      PATH=$PATH:/home/rap/Projects/SKE/azure/ske-bash-utils

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
        ssh -N babo -D 1337 
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
      docker = "podman";
      vim = "nvim";
      j = "jump";

      # Shortcuts
      clr = "clear";
      pbcopy = "xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard -o";
      ct = "cortextool";
      tf = "terraform";
      g = "gardenctl";
      k = "kubectl";
      kns = "kubens";
      kctx = "kubectx";
      pui = "pulumi";
      o = "openstack";
      selg = ". selg";

      # esp-suite
      esp-export = "source ~/esp/esp-idf/export.sh";
      esp-build = "idf.py -p /dev/ttyUSB0 -b 115200 build";
      esp-flash = "idf.py -p /dev/ttyUSB0 -b 115200 flash";
      esp-monitor = "idf.py -p /dev/ttyUSB0 -b 115200 monitor";
    };

    plugins = with pkgs; [
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = "${zsh-fast-syntax-highlighting}/share/zsh/site-functions";
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
