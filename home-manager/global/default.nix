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

    ../../nixos/common/nix.nix
  ];

  programs.home-manager.enable = true;

  xdg.enable = true;

  news = {
    display = "silent";
    json = lib.mkForce {};
    entries = lib.mkForce [];
  };

  # TODO: nix config here
}
