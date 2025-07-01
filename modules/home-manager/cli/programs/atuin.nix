{
  sops.secrets.atuin = {
    sopsFile = ./secrets.yaml;
    path = "/home/rap/.config/atuin/config.toml";
    mode = "777";
  };
  programs.atuin = {
    enable = true;
    flags = [
      "--disable-up-arrow"
    ];
  };
}
