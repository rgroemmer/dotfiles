{pkgs, inputs, ...}: {
  imports = [
    ../../../modules/nixos/common
    ../../../modules/nixos/k3s

    inputs.disko.nixosModules.disko

    ./hardware-configuration.nix
    ./disko.nix
  ];
  environment.systemPackages = with pkgs; [kubectl];
  system.stateVersion = "24.11";
}
