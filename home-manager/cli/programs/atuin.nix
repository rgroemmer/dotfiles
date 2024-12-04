{
  programs.atuin = {
    enable = true;
    flags = [
      "--disable-up-arrow"
    ];
    settings = {
      # Defaults for new installations (`atuin default-config`)
      sync.records = true;
      enter_accept = true;

      style = "compact";
      inline_height = 20;
      show_tabs = false;

      # sync_address = "https://atuin.lab.rockwolf.eu";
    };
  };
}
