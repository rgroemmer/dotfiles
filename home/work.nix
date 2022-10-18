{ ... }: {
  home.file.".garden/config" = {
    text = ''
      email: raphael.groemmer@yahoo.de
      gardenClusters:
      - name: dev
        kubeConfig: ~/.garden/kubeconfigs/dev.yaml
      - name: prd
        kubeConfig: ~/.garden/kubeconfigs/prd.yaml
      - name: tst
        kubeConfig: ~/.garden/kubeconfigs/tst.yam
    '';
  };
}