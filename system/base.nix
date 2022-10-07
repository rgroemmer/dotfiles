{}: {
  # TODO remove outcommeted if not needed
	nix = {
    # package = pkgs.nixVersions.stable;
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
    experimental-features = nix-command flakes
    keep-outputs = true
    keep-derivations = true
	  '';
	};
  
  # Network configuration
  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "nixos-rap";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Berlin";

	# Prevent suspend.
	powerManagement.enable = false;
	systemd.targets.sleep.enable = false;
	systemd.targets.suspend.enable = false;
	systemd.targets.hibernate.enable = false;
	systemd.targets.hybrid-sleep.enable = false;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.utf8";
      LC_IDENTIFICATION = "de_DE.utf8";
      LC_MEASUREMENT = "de_DE.utf8";
      LC_MONETARY = "de_DE.utf8";
      LC_NAME = "de_DE.utf8";
      LC_NUMERIC = "de_DE.utf8";
      LC_PAPER = "de_DE.utf8";
      LC_TELEPHONE = "de_DE.utf8";
      LC_TIME = "de_DE.utf8";
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  # Desktop Environment
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

  # Enable printer
  services.printing.enable = true;

  # Enable PipeWire
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

  # Install nerdfont
	fonts.fonts = with pkgs; [
		(nerdfonts.override { fonts = [ "CascadiaCode" ]; })
	];

  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
  ];
  services.openssh.enable = false;

}