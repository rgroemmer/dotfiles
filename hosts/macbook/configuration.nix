{ pkgs, outputs, inputs, ... }:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager.users.groemmer = import ./home.nix;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  users.users.groemmer = {
    home = "/Users/groemmer";
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = 4;
}

