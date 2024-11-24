{lib, ...}: {
  boot = {
    supportedFilesystems = ["ntfs"];
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = lib.mkDefault true;
  };
}
