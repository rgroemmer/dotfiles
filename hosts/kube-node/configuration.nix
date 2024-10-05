{ pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    extraOptions = "experimental-features = nix-command flakes";
  };

  services.openssh.enable = true;
  users.extraUsers.root.password = "nixos";
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqKYXW07z0llbDKRIakLD1PjHe3HxK9iu6czXs+ZU7v iso@rapsn"
  ];

  networking.hostName = "node01";
  environment.systemPackages = with pkgs; [ git curl neovim kubectl ];

  system.stateVersion = "24.11";
}
