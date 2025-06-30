{
  inputs,
  lib,
  pkgs,
  ...
}: {
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

    # Add each flake input as a registry
    # To make nix3 commands consistent with the flake
    # TODO: To use nixpkgs-stable for kubex, need to change this function, dueto the lib.nixosSystem which already sets the registry, this will be called the secound time, which will fail.
    # BUG: Find out if all registry are needed to be set.
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # Add nixpkgs input to NIX_PATH
    # This lets nix2 commands still use <nixpkgs>
    nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];
  };
}
