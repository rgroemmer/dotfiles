{pkgs, ...}: {
  users.users.rap = {
    isNormalUser = true;
    shell = pkgs.zsh;
    packages = [pkgs.home-manager];
    mutableUsers = true;
    hashedPassword = "$y$j9T$DZQaaK3xGqarN8KE8qnw..$dvgiS7dso5LboGRRf0dcyct/LQUFp4J0LUo2ZRRdTr8";
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
      "docker"
      "wireshark"
    ];
    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIPpUm00z/9wyWNPzuvjtVYYo5H+ZeKDahNK4YqvoNE5CAAAABHNzaDo= swiss_zi0n_north"
    ];
  };
  services.openssh.enable = true;
}
