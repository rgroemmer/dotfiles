{ user, ... }: {
  security.sudo.wheelNeedsPassword = false;

  programs = { zsh.enable = true; };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
  };

  users.users.${user} = {
    extraGroups = [
      "wheel" # sudo
      "networkmanager"
      "podman" # allows connection to docker socket
    ];
  };
}
