{
  programs.k9s = {
    enable = true;
    catppuccin.enable = true;
    plugin.plugins = {
      edit-secret = {
        description = "Edit Decoded Secret";
        shortCut = "Ctrl-X";
        scopes = ["secrets"];
        command = "kubectl";
        background = false;
        args = [
          "modify-secret"
          "-n"
          "$NAMESPACE"
          "$NAME"
        ];
      };
    };
  };
}
