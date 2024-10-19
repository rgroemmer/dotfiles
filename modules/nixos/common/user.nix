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
  };
}
