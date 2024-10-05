{
  disko.devices = {
    disk = {
      local = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
              size = "512";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
                extraArgs = "-nBOOT";
              };
            };
            root = {
              size = "100%";
              name = "root";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                extraArgs = "-LROOT";
              };
            };
          };
        };
      };
    };
  };
}
