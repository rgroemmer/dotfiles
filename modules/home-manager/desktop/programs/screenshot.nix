{pkgs, ...}: let
  screenshoot = pkgs.writeShellScriptBin "screenshoot" ''
    #!/usr/bin/env bash

    grimblast save area
  '';
in {
  home.packages = with pkgs; [
    grimblast
    # slurp

    screenshoot
  ];
}
