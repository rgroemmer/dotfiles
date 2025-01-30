{
  pkgs,
  lib,
  config,
  self,
  ...
}: {
  imports = [
    ./aerospace.nix
  ];

  config = lib.mkIf config.roles.work {
    home.packages = with pkgs; [
      # CLI
      stackit-cli
      openstackclient

      # Tools
      terraform
      ansible
      vault-bin
      nerd-fonts.caskaydia-cove

      # Tiling-manager
      aerospace

      # Terminal (as scratchy)
      iterm2
    ];

    home.activation = let
      path = builtins.toString self;
    in {
      home-care = lib.hm.dag.entryAfter ["writeBoundary"] ''
        STATE_FILE="$HOME/.local/share/home-manager/_current_generation"
        [ -f "$STATE_FILE" ] || touch "$STATE_FILE"

        STATE=$(cat "$STATE_FILE")
        NEW_STATE=$(sha256sum ${path}/flake.lock | awk '{print $1}')

        if [ ! "$STATE" = "$NEW_STATE" ]; then
          brew update && brew upgrade 2>/dev/null
          krew update && krew upgrade 2>/dev/null
          echo "$NEW_STATE" > $STATE_FILE
        fi
      '';
    };
  };
}
