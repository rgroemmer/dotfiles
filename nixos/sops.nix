{
  inputs,
  ...
}:
{

  /*
    sops-nix for sensitive secrets
    sops-nix will mount secrets under `/run/secrets` with the permissions secified in body.
    the secrets can then be used with e.g. cat.
    Example:
      cat ${sops.secrets."users/my-user/password".path}
  */

  imports = [ inputs.sops-nix.nixosModules.sops ];
  sops = {

    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    #TODO: make use of it
    age.keyFile = "/home/rap/.config/sops/age/keys.txt";
    secrets.fuck = {
      path = "/home/rap/.moinsen";
      owner = "rap";
    };
  };
}
