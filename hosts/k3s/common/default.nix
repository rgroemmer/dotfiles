{
  imports = [
    ../../../nixos

    ./hardware-configuration.nix
    ./disko.nix
  ];

  # Host specific configuration
  system = {
    boot.systemd = true;
    user = {
      name = "k3s";
      # TODO: use sops-nix file
      initialHashedPassword = "$y$j9T$8uQSJbY6w9kjXnj74JKjA1$pWYgNf.gb497suX//oIw6aggEPoD2Xv1kvMKZfDTOU/";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqKYXW07z0llbDKRIakLD1PjHe3HxK9iu6czXs+ZU7v";
      extraOptions = {};
      extraGroups = [];
    };
    modules.k3s.enable = true;
  };

  environment.variables = {
    PROMPT = "%m@%n> ";
    RPROMPT = "%D%T";
  };

  nix.settings.trusted-users = ["@wheel"]; # need for remote build
}
