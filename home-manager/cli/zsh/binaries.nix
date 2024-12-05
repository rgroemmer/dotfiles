{pkgs, ...}: let
  # nix helper aliases
  nix_run = pkgs.writeShellScriptBin "nr" ''
    #!/usr/bin/env bash
    nix run nixpkgs#"$@"
  '';
  nix_shell = pkgs.writeShellScriptBin "ns" ''
    #!/usr/bin/env bash
    nix shell nixpkgs#"$@"
  '';
in {
  home.packages = [
    nix_run
    nix_shell
  ];
}
