{lib, ...}: {
  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = lib.mkDefault true;
  };
}
