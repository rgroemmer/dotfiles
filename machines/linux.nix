{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Hardware configuration

  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "ahci"
        "xhci_pci"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [ ];
    };
    
    kernelModules = [ "kvm-amd" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
  };

  # TODO make by label
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-partlabel/root";
      fsType = "ext4";
    };
    "/nix/store" = { 
      device = "/nix/store";
      fsType = "none";
      options = [ "bind" ];
    };
    "/boot/efi" = { 
      device = "/dev/disk/by-partlabel/boot";
      fsType = "vfat";
    };
  };

  hardware = {
    # recommended on screens larger than fullhd
    video.hidpi.enable = lib.mkDefault true;

    opengl.enable = true;
    cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
  };
}