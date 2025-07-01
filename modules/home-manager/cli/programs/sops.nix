{config, ...}: {
  # TODO: move from nixos here
  sops.age = {
    generateKey = true;
    keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };
}
