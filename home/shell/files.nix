{ ... }: {
  home.file = 
  let 
    path = "Projects";
  in {
    # Project structure setup
    "${path}/SKE/github/.keep".text = "keep";
    "${path}/SKE/azure/.keep".text = "keep";
    "${path}/SKE/playground/.keep".text = "keep";
    "${path}/SKE/tools/.keep".text = "keep";

    "${path}/RAPSN/github/.keep".text = "keep";
    "${path}/RAPSN/playground/.keep".text = "keep";
    "${path}/RAPSN/tools/.keep".text = "keep";

    # Gardenctl setup
    ".garden/config" = {
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
      ".garden/kubeconfigs/.keep".text = "keep";
      ".config/kubeconfigs/.keep".text = "keep";

      ".gnupg/gpg-agent.conf".text = ''
        default-cache-ttl 18000
        max-cache-ttl 22000
      '';
  };
}



