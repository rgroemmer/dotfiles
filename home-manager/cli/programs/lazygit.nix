{config, ...}: {
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        autoFetch = false; # does not work when SSH key requires password (ref: https://github.com/jesseduffield/lazygit/issues/1498)
        paging = {
          colorArg = "always";
          pager = "${config.programs.git.delta.package}/bin/delta --dark --paging=never";
        };
      };
      # TODO: check if this is needed, its buggy with nvim-oil
      # os = {
      #   editPreset = "nvim-remote";
      #   edit = ''[ -z "$NVIM" ] && (nvim -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{filename}})'';
      #   editAtLine = ''[ -z "$NVIM" ] && (nvim +{{line}} -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" &&  nvim --server "$NVIM" --remote {{filename}} && nvim --server "$NVIM" --remote-send ":{{line}}<CR>")'';
      #   openDirInEditor = ''[ -z "$NVIM" ] && (nvim -- {{dir}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{dir}})'';
      # };
    };
  };
}
