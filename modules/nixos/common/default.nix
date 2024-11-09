{
  imports = [
    ./user.nix
    ./locale.nix
    ./environment.nix
    ./systemd.nix
    ./grub.nix
    # TODO: configure & enable + docs
    #./sops.nix
  ];
}
