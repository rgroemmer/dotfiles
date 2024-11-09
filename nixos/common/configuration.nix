{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = ["ntfs"];
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
  };

  programs.zsh.enable = true;

  environment = {
    pathsToLink = ["/share/zsh"]; # autocompletion
    systemPackages = with pkgs; [
      htop
      curl
      git
      neovim
      gparted
    ];
    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };
}
