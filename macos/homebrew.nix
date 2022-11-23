{ config, pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      # "zap" removes manually installed brews and casks
      cleanup = "zap";
      autoUpdate = true;
    };
    brews = [
      "helm"
      "yabai"
      "skhd"
      "sketchybar"
      "neovim"
    ];
    casks = [
      "docker" # docker desktop

      "bartender"
      # communication
      "zoom"
      "slack"
      "mumble" # teamspeak alternative
      "signal" # messenger
      "alfred"
      "rocket-chat"
      "alacritty"
      "iterm2"
      "firefox-developer-edition"
      "font-caskaydia-cove-nerd-font"
      "font-fontawesome"

      "nextcloud"
    ];

    taps = [
      # default
      "homebrew/cask-versions"
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/core"
      "homebrew/services"
      # custom
      "koekeishiya/formulae" # yabai
      "FelixKratz/formulae" # sketchybar
      "cmacrae/formulae" # spacebar
    ];
  };
}
