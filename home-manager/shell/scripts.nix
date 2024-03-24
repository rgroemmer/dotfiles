{ pkgs, ... }: let

  selc = pkgs.writeShellScriptBin "selc" ''
    #!/usr/bin/env bash
    BASE_PATH=~/.config/kubeconfig
    YAMLS=$(find $BASE_PATH -name '*.yaml' | awk -F/ '{ print $NF }')
    KUBECONFIG=$(echo $YAMLS | fzf)
    export KUBECONFIG=$BASE_PATH/$KUBECONFIG
  '';

in {
  home.packages = [ selc ];
}
