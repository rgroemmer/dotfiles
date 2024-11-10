{
  programs.krewfile = {
    enable = true;

    plugins = [
      "explore"
      "modify-secret"
      "neat"
      "oidc-login"
      "pv-migrate"
      "stern"
      "node-shell"
    ];
  };
}
