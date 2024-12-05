{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../nixos
  ];

  # Host specific configuration
  system = {
    boot = {
      grub = true;
      armSupport = true;
      supportedFilesystems = ["ntfs"];
    };
    user = {
      name = "rap";
      extraGroups = [
        "networkmanager"
        "docker"
        "wireshark"
      ];
      extraOptions = {
        initialHashedPassword = "$y$j9T$DZQaaK3xGqarN8KE8qnw..$dvgiS7dso5LboGRRf0dcyct/LQUFp4J0LUo2ZRRdTr8";
      };
    };
    services = {
      printing = true;
      sound = true;
      bluetooth = true;
      opengl = true;
    };
    modules = {
      desktop = true;
      gaming = true;
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true; # realtime-kit
    sudo.wheelNeedsPassword = false;
    pam.services.swaylock.text = "auth include login"; # enable swaylock to login
  };

  networking = {
    hostName = "zion";
    networkmanager.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [qt6.qtwayland];

    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
  };

  services.udev.packages = with pkgs; [
    qmk-udev-rules
    android-udev-rules
  ];
}
