{
  inputs,
  config,
  ...
}: let
  user = config.system.user.name;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    age = {
      keyFile = "/home/${user}/.config/sops/age/keys.txt";
    };
  };
}
