{pkgs, ...}: {
  # Autoclone the repository
  systemd.services.git-repo-init = {
    description = "Clone a Git repository to a path if it does not exist";
    after = ["network-online.target"]; # Ensure network is ready
    wantedBy = ["multi-user.target"]; # Run this at boot

    serviceConfig = {
      Type = "oneshot"; # Run the service once
      ExecStart = "${pkgs.git}/bin/git clone https://github.com/rgroemmer/dotfiles.git /home/rap";
      ExecCondition = "! [ -d /home/rap/dotfiles ]"; # Only run if the repo isn't already cloned
    };
  };
}
