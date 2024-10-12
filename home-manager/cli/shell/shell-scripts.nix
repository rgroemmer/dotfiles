{ pkgs, ... }:
let
  proxyConnect = pkgs.writeShellScriptBin "proxyConnect" ''
    #!/usr/bin/env bash
    if [[ -e /tmp/.ssh-jump-ske ]]; then
      echo "SSH Proxy already connected"
      return
    fi
    ssh jump-ske -fN -M -S /tmp/.ssh-jump-ske
    ssh jump-stoi-qa -fN -M -S /tmp/.ssh-jump-stoi-qa
    ssh jump-stoi-prod -fN -M -S /tmp/.ssh-jump-stoi-prod
  '';
  proxyDisconnect = pkgs.writeShellScriptBin "proxyDisconnect" ''
    #!/usr/bin/env bash
    ssh -S /tmp/.ssh-jump-ske -O exit jump-ske
  '';
in
{
  home.packages = [
    proxyConnect
    proxyDisconnect
  ];
}
