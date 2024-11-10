{pkgs, ...}: {
  programs = {
    home.packages = with pkgs; [
      # CLIs
      stackit-cli
      terraform

      # Tools
      vault-bin
    ];
  };
}
