{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.system.modules.desktop;
in {
  config = mkIf cfg {
    programs.hyprland.enable = true;

    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland &> /dev/null";
          user = config.system.user.name;
        };
        default_session = initial_session;
      };
    };
  };
}
