{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    # module inputs
    inputs.catppuccin.homeModules.catppuccin
    inputs.neonix.homeManagerModules.neonix
    inputs.krewfile.homeManagerModules.krewfile
    inputs.sops-nix.homeManagerModules.sops

    # custom role definition
    ./roles.nix

    # global nix & nixpkgs settings
    ../../nix.nix
  ];

  programs.home-manager.enable = true;

  xdg.enable = true;

  sops.age = {
    generateKey = true;
    keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };

  news = {
    display = "silent";
    json = lib.mkForce {};
    entries = lib.mkForce [];
  };
}
