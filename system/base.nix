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
    hostName = "nixos";
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1 api.local.local.external.local.gardener.cloud
      127.0.0.1 api.local.local.internal.local.gardener.cloud
    '';
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

  hardware.opengl.enable = true;
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  environment = {
    systemPackages = with pkgs; [
      htop
      curl
      git
      vim
      nvtop # gpu monitor
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  # enables realtime processing
  security.rtkit.enable = true;

  sound.enable = true;

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      layout = "eu";

      # keyboard repeat time
      autoRepeatInterval = 35;
      autoRepeatDelay = 320;

      # home-manager handles xsession
      desktopManager = {
        xterm.enable = false;
        # get default xfce tools
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
        # wallpaper at ~./background-image will be used
        wallpaper.mode = "fill";
        session = [{
          name = "xsession";
          start = ''
            ${pkgs.runtimeShell} $HOME/.xsession &
            waitPID=$!
          '';
        }];
      };
    };

    printing.enable = true;
    gnome.gnome-keyring.enable = true;

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

    udev.packages = with pkgs; [
      qmk-udev-rules
    ];
  };
  
  programs = {
   ssh.startAgent = true;
   gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
   };
   noisetorch = {
    enable = true;
   };
  };
}
