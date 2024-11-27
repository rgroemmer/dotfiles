{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.modules.k3s.enable {
    fileSystems."/mnt/k3s_openebs_main" = {
      device = "192.168.55.10:/main_pool_z2/k3s_openebs_main";
      fsType = "nfs";
      options = [
        "rw"
        "vers=4"
        "noatime"
      ];
    };
  };
}
