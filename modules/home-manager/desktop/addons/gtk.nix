{
  # NOTE: Its deprecated, but as long it looks nice...
  catppuccin.gtk.enable = true;
  gtk = {
    enable = true;

    #theme = {
    #  name = "adw-gtk3-dark";
    #  package = pkgs.adw-gtk3;
    #};

    # iconTheme = {
    #   package = pkgs.catppuccin-papirus-folders.override {
    #     flavor = "mocha";
    #     accent = "lavender";
    #   };
    #   name = "Papirus-Dark";
    # };

    gtk3.extraConfig = {
      gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
      gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-decoration-layout = "appmenu:none";
      gtk-button-images = 1;
      gtk-menu-images = 1;
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintfull";
      gtk-error-bell = 0;
      gtk-application-prefer-dark-theme = true;
      gtk-recent-files-max-age = 0;
      gtk-recent-files-limit = 0;
    };

    gtk4.extraConfig = {
      gtk-decoration-layout = "appmenu:none";
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintfull";
      gtk-error-bell = 0;
      gtk-application-prefer-dark-theme = true;
      gtk-recent-files-max-age = 0;
    };
  };

  home.sessionVariables.GTK_THEME = "Tokyonight-Storm-B";
  # home.pointerCursor = {
  #   name = "hyprcursor";
  #   package = pkgs.hyprcursor;
  #   hyprcursor = {
  #     enable = true;
  #   };
  # };
}
