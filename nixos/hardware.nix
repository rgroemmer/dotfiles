{
  hardware.bluetooth.enable = true;

  powerManagement.enable = false;
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
  };

  time.hardwareClockInLocalTime = true;

  environment.pathsToLink = [ "/share/zsh" ];

  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    blueman.enable = true;
  };
}
