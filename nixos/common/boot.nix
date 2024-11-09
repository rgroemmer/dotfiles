{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = ["ntfs"];
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
  };
}
