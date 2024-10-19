{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # components

  # host specific configuration
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

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
    systemPackages = with pkgs; [ qt6.qtwayland ];

    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
  };

  services.udev.packages = with pkgs; [
    qmk-udev-rules
    android-udev-rules
  ];

  system.stateVersion = "22.05";
}
