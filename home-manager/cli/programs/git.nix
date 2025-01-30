{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    gh
  ];

  programs = {
    git = {
      enable = true;
      userEmail =
        if config.roles.work
        then "raphael.groemmer@stackit.de"
        else "mail@rapsn.me";
      userName = "Raphael Groemmer";

      delta.enable = true;
      ignores = [
        ".idea"
        ".vs"
        ".vsc"
        ".vscode" # ide
        ".DS_Store" # mac
        "node_modules"
        "npm-debug.log" # npm
        "__pycache__"
        "*.pyc" # python
        ".ipynb_checkpoints" # jupyter
        "__sapper__" # svelte
      ];

      extraConfig = {
        commit = {
          gpgsign = false;
        };
        fetch.prune = true;
        init = {
          defaultBranch = "main";
        };
        pull = {
          ff = false;
          commit = false;
          rebase = true;
        };
        url = {
          "git@github.com:stackitcloud" = {insteadOf = "https://github.com/stackitcloud";};
        };
        push.autoSetupRemote = true;
        delta = {
          line-numbers = true;
        };
      };

      includes = [
        {
          condition = "gitdir:~/Projects/rgroemmer/**";
          contents = {
            user.email = "mail@rapsn.me";
          };
        }
      ];
    };
  };
}
