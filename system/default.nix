{ pkgs, lib, ... }: {
  imports = [
    ./base.nix
    ./user.nix
  ];
}