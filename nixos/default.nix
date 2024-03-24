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
    ./nix.nix
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
    gvfs.enable = true;
    udisks2.enable = true;

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
