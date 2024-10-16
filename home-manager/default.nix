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

  xdg.enable = true;

  news = {
    display = "silent";
    json = lib.mkForce { };
    entries = lib.mkForce [ ];
  };
}
