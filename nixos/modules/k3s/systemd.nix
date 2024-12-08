{pkgs, ...}: {
  # Autoclone the repository
  systemd.services.git-repo-init = {
    description = "Clone a Git repository to a path if it does not exist";

    wantedBy = ["multi-user.target"]; # Run this at boot
    requires = ["network-online.target"];
    after = ["network-online.target"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.git}/bin/git clone https://github.com/rgroemmer/dotfiles.git /home/rap";
      ExecCondition = "${pkgs.coreutils}/bin/test ! [ -d /home/rap/dotfiles ]";
    };
  };
}
