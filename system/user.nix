{}: {
  	# Enable Zsh.
	programs.zsh = {
		enable = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
      enableCompletion = false;

		promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
	};


    # TODO: Move to home manager, only configure shell and groups
    users.users.rap = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "podman"]; # Enable ‘sudo’ for the user.
        packages = with pkgs; [
        # CLI programs
        neovim
        xclip
        git
        gh
        man-pages
        man-db
        ripgrep
        alsa-utils
        zip
        bat
        nix-direnv
        htop
        exa
        kubectl
        podman
        vault
        bind
        go
        jq
        borgbackup
        thefuck
        zsh-autopair


        # TUI programs
        k9s

        # GUI programs
        firefox
        vivaldi
        flameshot
        alacritty
        nextcloud-client
        keepassxc
        spotify
        postman

        # Chat
        discord
        rocketchat-desktop
        mumble
        slack
        ];
    };

}