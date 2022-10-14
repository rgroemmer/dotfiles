{ pkgs, lib, ... }: {
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
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
  
  # environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  
  environment = {
    systemPackages = with pkgs; [
      htop
      curl
      git
      neovim
      nvtop # gpu monitor
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  # Desktop Environment
  services.xserver = {
    enable = true;
    layout = "de";

    # keyboard repeat time
    autoRepeatInterval = 35;
    autoRepeatDelay = 320;

    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };

    displayManager = { defaultSession = "none+i3"; };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ dmenu i3status i3lock i3blocks ];
    };
  };

  # enables realtime processing
  security.rtkit.enable = true;
  
  sound.enable = true;
  services = {
    printing.enable = true;

    # enable pipewire
    pipewire = {
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
  };

  # Enable printer
  services.printing.enable = true;

  # Install nerdfont
  fonts.fonts = with pkgs;
    [ (nerdfonts.override { fonts = [ "CascadiaCode" ]; }) ];

  services.openssh.enable = false;
}
