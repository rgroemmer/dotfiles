{ pkgs, ... }:
{
  users.users.rap = {
    isNormalUser = true;
    shell = pkgs.zsh;
    packages = [ pkgs.home-manager ];
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
  programs.zsh.enable = true;
  services.openssh.enable = true;
}
