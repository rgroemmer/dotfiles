{
  inputs,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../static/secrets.yaml;
    defaultSopsFormat = "yaml";

    #TODO: make use of it
    age.keyFile = "/home/rap/.config/sops/age/keys.txt";
    secrets.fuck = {
      path = "/home/rap/.moinsen";
      owner = "rap";
    };
  };
}
