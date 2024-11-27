{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.system.user;
in
  with lib; {
    options.system.user = with types; {
      name = mkOption {type = str;};
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
          isNormalUser = true;
          shell = pkgs.zsh;
          extraGroups =
            [
              "wheel"
              "video"
              "audio"
            ]
            ++ cfg.extraGroups;
          openssh.authorizedKeys.keys = [
            "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIPpUm00z/9wyWNPzuvjtVYYo5H+ZeKDahNK4YqvoNE5CAAAABHNzaDo= swiss_zi0n_north"
          ];
        }
        // cfg.extraOptions;

      # User config
      programs.zsh.enable = true;
      environment.pathsToLink = ["/share/zsh"]; # autocompletion
      services.openssh.enable = true;
    };
  }
