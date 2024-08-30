{ pkgs, ... }:
let
  switchCMDs = {
    "x86_64-linux" = "sudo nixos-rebuild switch --flake '.#zion'";
    "aarch64-darwin" = "nix run nix-darwin -- switch --flake .\#macbook";
  };
  switch = builtins.getAttr pkgs.system switchCMDs;
in
{
  devShells.default = pkgs.mkShell {
    packages = with pkgs; [
      treefmt
      nixfmt-rfc-style
      yamlfmt
    ];
    nativeBuildInputs = [
      # targets to execute like a makefile
      (pkgs.writeShellScriptBin "run" ''
        #!/usr/bin/env bash

        if [ $# -eq 0 ]; then
          ${switch}
          exit
        fi

        fmt() {
          treefmt --tree-root=.
        }
        # exec cmd passed as arg
        "$@"
      '')
    ];
    shellHook = ''
      hostname > .hostname
    '';
  };
}
