{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  # Host specific configuration
  hostConfiguration = {
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
      keys = [];
    };

    services = {
      printing = true;
      sound = true;
      bluetooth = true;
      opengl = true;
      podman = true;
      tailscale = true;
    };

    roles = {
      desktop = true;
      gaming = true;
    };
  };

  # FIXME: Remove when move to HM is fine
  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-gtk
  #     xdg-desktop-portal-hyprland
  #   ];
  # };

  # Secrets for host
  # TODO: concider to remove + docu for ssh-keygen -K (new host setup docs!)
  sops.secrets = let
    user = config.hostConfiguration.user.name;
  in {
    ssh_config = {
      sopsFile = ./secrets.yaml;
      path = "/home/rap/.ssh/config";
      owner = user;
      group = "root";
      mode = "600";
    };
    yubi = {
      sopsFile = ./secrets.yaml;
      path = "/home/rap/.ssh/yubi";
      owner = user;
      group = "root";
      mode = "600";
    };
    swiss = {
      sopsFile = ./secrets.yaml;
      path = "/home/rap/.ssh/swiss";
      owner = user;
      group = "root";
      mode = "600";
    };
  };

  # TODO: move to security module
  security = {
    polkit.enable = true;
    rtkit.enable = true; # realtime-kit
    sudo.wheelNeedsPassword = false;
  };

  services.gnome.gnome-keyring.enable = true;

  networking = {
    hostName = "zion";
    networkmanager.enable = true;
    interfaces.enp16s0 = {
      wakeOnLan.enable = true;
    };
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
