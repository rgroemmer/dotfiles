{
  pkgs,
  outputs,
  inputs,
  ...
}:
{
  imports = [
    # import home-manager function
    inputs.home-manager.darwinModules.home-manager
    ./darwin.nix
    ../../nix.nix
  ];

  # entrypoint for home-manager
  home-manager.users.groemmer = import ./home.nix;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  users.users.groemmer = {
    home = "/Users/groemmer";
    shell = pkgs.zsh;
  };

  nix.useDaemon = true;

  system.stateVersion = 4;
}
