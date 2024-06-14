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
      "iproute2mac"
      "parallel"

      #----- core for work -----#
      "openstackclient"
      "terraform"
      "earthly"
      "vault-cli"
      "sonobuoy"

      #----- i3ish tiling desktop -----#
      "koekeishiya/formulae/yabai"
      "koekeishiya/formulae/skhd"
    ];
    casks = [
      # dirty workaround to have it through spotlight search
      "alacritty"
      "iterm2"

      #----- clis for work -----#
      "fly"

      #----- uis for work -----#
      "rocket-chat"
      "postman"
      "slack"
      "mumble"
      "firefox-developer-edition"

      #----- mac tooling -----#
      "alfred"
      "karabiner-elements"

      #----- default tools -----#
      "keepassxc"
      "spotify"
      "postman"

    ];

    taps = [
      # default
      "gardener/tap"
      "homebrew/bundle"
      "homebrew/services"
      # custom
      "koekeishiya/formulae" # yabai
    ];
  };
}
