{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: {
  options.system.stable = lib.mkEnableOption "Use stable nixpkgs";

  config = {
    nixpkgs = {
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };

    nix = {
      package = lib.mkDefault pkgs.nix;

      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        warn-dirty = false;
      };

      # Add nixpkgs flake input as a registry to make nix3 commands consistent with the flake.
      registry = {
        nixpkgs = {
          flake =
            if config.system.stable
            then inputs.nixpkgs-stable
            else inputs.nixpkgs;
        };
      };

      # Add nixpkgs input to NIX_PATH, to make nix2 commands consistent with the flake.
      nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];
    };
  };
}
