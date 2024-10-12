{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.neonix.homeManagerModules.neonix
    inputs.krewfile.homeManagerModules.krewfile

    ../nix.nix
  ];

  programs = {
    home-manager.enable = true;
    neonix.enable = true;

    krewfile = {
      enable = true;

      plugins = [
        "explore"
        "modify-secret"
        "neat"
        "oidc-login"
        "pv-migrate"
        "stern"
        "node-shell"
      ];
    };
  };

  nix.gc = {
    automatic = true;
    frequency = "weekly";
    options = "--delete-older-than 2d";
  };

  xdg.enable = true;

  news = {
    display = "silent";
    json = lib.mkForce { };
    entries = lib.mkForce [ ];
  };
}
