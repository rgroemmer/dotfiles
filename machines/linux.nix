{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Hardware configuration
  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "ahci" "xhci_pci" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };

    kernelModules = [ "kvm-amd" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
  };

  # TODO change to by-label
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b4cb94e3-d8d7-4f71-9cc5-f08c5bb62537";
    fsType = "ext4";
  };

  fileSystems."/nix/store" = {
    device = "/nix/store";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/434C-CA63";
    fsType = "vfat";
  };

  hardware = {
    # recommended on screens larger than fullhd
    video.hidpi.enable = lib.mkDefault true;

    opengl.enable = true;
    cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
  };
}

