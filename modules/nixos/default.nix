{
  pkgs,
  inputs,
  outputs,
  ...
}:
{
  imports = [
    ../common

    ./auto-upgrade.nix
    ./docker.nix
    ./fonts.nix
    ./greetd.nix
    ./hardware.nix
    ./locale.nix
    ./opengl.nix
    ./sound.nix
    ./user.nix
    ./sops.nix
    ./thunar.nix
  ];

  services = {
    pcscd.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;

    udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="18d1|096e", ATTRS{idProduct}=="5026|0858|085b", TAG+="uaccess"
    '';

    udev.packages = with pkgs; [
      qmk-udev-rules
      android-udev-rules
    ];
  };

  programs.hyprland.enable = true;
  system.stateVersion = outputs.stateVersion;
}
