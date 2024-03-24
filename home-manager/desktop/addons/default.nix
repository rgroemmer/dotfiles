{ inputs, pkgs, ... }:
{
  imports = [
    ./swaync
    ./waybar
    ./wlogout
    ./swaylock.nix
    ./qt.nix
    ./gtk.nix
    ./tofi.nix
  ];
}
