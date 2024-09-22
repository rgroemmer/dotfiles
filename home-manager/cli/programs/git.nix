{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "mail@rapsn.me";
    userName = "Raphael Groemmer";

    signing = {
      key = "5AAB7E380D3AC3D3";
      #signByDefault = true;
    };

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
      init = {
        defaultBranch = "main";
      };
      pull = {
        ff = false;
        commit = false;
        rebase = true;
      };
      push.autoSetupRemote = true;
      url = {
        #"git@github.com:" = {
        #  insteadOf = "https://github.com/";
        #};
        #  "git@ssh.dev.azure.com:v3" = { insteadOf = "https://dev.azure.com"; };
      };
      delta = {
        line-numbers = true;
      };
    };

    includes = [
      {
        condition = "gitdir:~/Projects/ske/**";
        contents = {
          user.email = "raphael.groemmer@stackit.de";
        };
      }
    ];
  };
}
