{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs;
    lib.mkIf (!config.roles.work) [
      rustup
      clang
    ];
}
