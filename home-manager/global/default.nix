{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.neonix.homeManagerModules.neonix
    inputs.krewfile.homeManagerModules.krewfile

    ../cli
    ../desktop

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
