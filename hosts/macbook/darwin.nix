{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
    };
    brews = [
      #----- k8s tooling + gardener -----#
      "gardenctl-v2"
      "gardenlogin"

      #----- core for work -----#
      "vault-cli"
    ];
    casks = [
      # dirty workaround to have it through spotlight search
      "alacritty"
      "iterm2"
      "linearmouse"
      "docker"

      #----- clis for work -----#
      "fly"

      #----- i3ish tiling desktop -----#
      "nikitabobko/tap/aerospace"

      #----- uis for work -----#
      "rocket-chat"
      "slack"
      "mumble"
      "firefox@developer-edition"

      #----- mac tooling -----#
      "alfred"
      "karabiner-elements"

      #----- default tools -----#
      "keepassxc"
      "spotify"

    ];

    taps = [
      # default
      "gardener/tap"
      "homebrew/bundle"
      "homebrew/services"
      "gardener/tap"
      # custom
      "nikitabobko/tap"
    ];
  };
}
