{
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager

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

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

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
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  system.stateVersion = outputs.stateVersion;
}
