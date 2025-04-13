{lib, ...}: {
  programs.pet = {
    enable = true;
    settings = {
      General = lib.mkForce {
        snippetfile = "~/Projects/rgroemmer/dotfiles/static/snippet.toml";
        selectcmd = "fzf --ansi";
        color = true;
      };
    };
  };
}
