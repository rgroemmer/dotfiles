{lib, ...}: {
  programs.pet = {
    enable = true;
    settings = {
      General = lib.mkForce {
        snippetfile = "~/Projects/rgroemmer/dotfiles/static/snippet.toml";
      };
    };
  };
}
