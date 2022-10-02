# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, callPackage, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

	# Add Flake support
	nix = {
	    package = pkgs.nixVersions.stable;
	    extraOptions = ''
			experimental-features = nix-command flakes
			keep-outputs = true
			keep-derivations = true
		'';
	};

    # Use the GRUB 2 boot loader.
    boot.loader.grub.enable = true;
    boot.loader.grub.version = 2;
    boot.loader.grub.device = "/dev/sda";

    # Networking
    networking.hostName = "rapos";
    networking.wireless.enable = false;
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Berlin";

	# Prevent suspend.
	powerManagement.enable = false;
	systemd.targets.sleep.enable = false;
	systemd.targets.suspend.enable = false;
	systemd.targets.hibernate.enable = false;
	systemd.targets.hybrid-sleep.enable = false;

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    # console = {
    #     font = "Lat2-Terminus16";
    #     keyMap = "de";
    #     useXkbConfig = true; # use xkbOptions in tty.
    # };

    # Desktop Enviroment
    environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
    services.xserver = {
        enable = true;
        layout = "de";

        desktopManager = {
        xterm.enable = false;
        xfce = {
            enable = true;
        noDesktop = true;
        enableXfwm = false;
    };
        };

        displayManager = {
            defaultSession = "none+i3";
        };

        windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
            dmenu
            i3status
            i3lock
            i3blocks
        ];
        };
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable PipeWire.
	sound.enable = false;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		audio.enable = true;
		pulse.enable = true;
		jack.enable = true;
		config = {
			pipewire = {
				default.clock.rate = 48000;
				resample.quality = 10;
			};
		};
		wireplumber.enable = true;
	};

	# Enable Zsh.
	programs.zsh = {
		enable = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
        autocd = true;
        enableCompletion = false;



		promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        ohMyZsh = {
          enable = true;
          plugins = [ 
            "git"
            "thefuck"
            "autojump"
            "kubectl"
            "zsh-autopair"
          ];
          theme = "robbyrussell";
        };
	};

	# Enable Steam.
	programs.steam = {
		enable = true;
	};

	# Install fonts.
	fonts.fonts = with pkgs; [
		(nerdfonts.override { fonts = [ "CascadiaCode" ]; })
	];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.rap = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
        packages = with pkgs; [
        neovim
        ];
    };

	# Allow unfree packages.
	nixpkgs.config = {
		allowUnfree = true;
		allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
			"steam"
			"steam-original"
			"steam-runtime"
		];
	};

    # List packages installed in system profile. To search, run:
	# $ nix search wget
    environment.systemPackages = with pkgs; [
        # CLI programs
        neovim
        xclip
        git
        gh
        man-pages
        man-db
        ripgrep
        pulseaudio
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

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}