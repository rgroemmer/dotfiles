{
  inputs,
  config,
  ...
}: let
  user = config.hostConfiguration.user.name;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    age = {
      generateKey = true;
      keyFile = "/home/${user}/.config/sops/age/keys.txt";
    };
  };
}
