{
  system.activationScripts.mybootstrap.text = ''
    KUBE_PATH="/home/k3s/.kube"
    if [[ ! -f "$KUBE_PATH/config" ]]; then
      mkdir -p $KUBE_PATH
      ln -s /etc/rancher/k3s/k3s.yaml $KUBE_PATH/config
      chown k3s:users $KUBE_PATH/config
    fi
  '';
}
