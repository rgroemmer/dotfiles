{ pkgs, config, ... }:
{

  # import entrypoint of home-manager
  home-manager.users.rap = import ../hosts/zion/home.nix;
  home-manager.verbose = true;

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

  programs.zsh.enable = true;
}
