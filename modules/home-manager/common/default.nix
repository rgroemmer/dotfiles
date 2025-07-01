{
  inputs,
  lib,
  ...
}: {
  imports = [
    # module inputs
    inputs.catppuccin.homeModules.catppuccin
    inputs.neonix.homeManagerModules.neonix
    inputs.krewfile.homeManagerModules.krewfile
    inputs.sops-nix.homeManagerModules.sops

    # custom module config definition
    ./modules.nix

    # global nix & nixpkgs settings
    ../../nix.nix
  ];

  programs.home-manager.enable = true;
  xdg.enable = true;

  news = {
    display = "silent";
    json = lib.mkForce {};
    entries = lib.mkForce [];
  };
}
