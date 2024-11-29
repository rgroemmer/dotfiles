{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.system.user;
in {
  options.system.user = with types; {
    name = mkOption {type = str;};
    initialHashedPassword = mkOption {type = str;};
    extraGroups = mkOption {
      type = listOf str;
      default = [];
      description = "Additional groups for the user.";
    };
    extraOptions = mkOption {
      type = attrs;
      description = "Additional options for the user.";
    };
  };

  config = {
    users.users.${cfg.name} =
      {
        isNormalUser =
          if cfg.name == "root"
          then false
          else true;

        shell = pkgs.zsh;

        initialHashedPassword = mkForce cfg.initialHashedPassword;
        openssh.authorizedKeys.keys = [
          "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIPpUm00z/9wyWNPzuvjtVYYo5H+ZeKDahNK4YqvoNE5CAAAABHNzaDo= swiss_zi0n_north"
        ];

        extraGroups =
          [
            "wheel"
            "video"
            "audio"
          ]
          ++ cfg.extraGroups;
      }
      // cfg.extraOptions;

    # User config
    programs.zsh.enable = true;
    environment.pathsToLink = ["/share/zsh"]; # autocompletion
    services.openssh.enable = true;
  };
}
