{ user, ... }: {
  security.sudo.wheelNeedsPassword = false;

  programs = { zsh.enable = true; };

  virtualisation = {
    podman = {
      enable = true;
      dockerSocket.enable = true;
    };
  };

  users.users.${user} = {
    extraGroups = [
      "wheel" # sudo
      "networkmanager"
      "podman" # allows connection to docker socket
      "dialout" # /dev/ttyUSB access
    ];
  };
}
