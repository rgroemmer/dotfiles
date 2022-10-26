{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userEmail = "mail@rapsn.me";
    userName = "Raphael Groemmer";

    delta.enable = true;
    ignores = [
      ".idea" ".vs" ".vsc" ".vscode" # ide
      ".DS_Store" # mac
      "node_modules" "npm-debug.log" # npm
      "__pycache__" "*.pyc" # python
      ".ipynb_checkpoints" # jupyter
      "__sapper__" # svelte
    ];
    
    extraConfig = {
      init = { defaultBranch = "main"; };
      pull = {
        ff = false;
        commit = false;
        rebase = true;
      };
      push.autoSetupRemote = true;
      url = {
        "ssh://git@github.com" = { insteadOf = "https://github.com"; };
      };
      delta = {
        line-numbers = true;
      };
    };

    includes = [{
      condition = "gitdir:~/Projects/SKE/**";
      contents = {
        user.email = "raphael.groemmer@stackit.de";
      };
    }];
  };
}