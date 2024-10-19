{
  pkgs,
  lib,
  config,
  ...
}:
let
  clusterDNS = "api.k3s.rapsn.me";
  hostName = config._module.specialArgs.name;
in
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
  };

  services.openssh.enable = true;

  users.users.root = {
    hashedPassword = "$y$j9T$EMO/EfdbflSVB//fPjqSi/$3jrcxQr/AEXtJZSXtc0ISAZbnqum.TW9vIi8bgMA2F1";
    initialHashedPassword = lib.mkForce null;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqKYXW07z0llbDKRIakLD1PjHe3HxK9iu6czXs+ZU7v iso@rapsn"
    ];
  };


  environment.systemPackages = with pkgs; [
    git
    curl
    neovim
    kubectl
  ];

  system.stateVersion = "24.11";

  # Service area
  services.k3s = {
    enable = true;
    role = "server";
    # todo: encrypt
    token = "1234";
    clusterInit = if hostName == "k3s-m0" then true else false;
    serverAddr = if hostName == "k3s-m0" then "" else clusterDNS;
  };
}
