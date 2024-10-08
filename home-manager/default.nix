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

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    # TODO: remove or use
    #overlays = [
    #  inputs.rockwolf-dotfiles.overlays.python-openstackclient
    #];
  };

  xdg.enable = true;

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      trusted-substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      experimental-features = [
        "nix-command"
        "flakes"
        "repl-flake"
      ];
      warn-dirty = false;
      use-xdg-base-directories = true;
    };
  };

  news = {
    display = "silent";
    json = lib.mkForce { };
    entries = lib.mkForce [ ];
  };
}
