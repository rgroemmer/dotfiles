{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ../../nixos

    inputs.disko.nixosModules.disko
  ];

  # Host specific configuration
  system = {
    boot.systemd = true;
    user = {
      name = "mini";
      initialHashedPassword = "$y$j9T$8uQSJbY6w9kjXnj74JKjA1$pWYgNf.gb497suX//oIw6aggEPoD2Xv1kvMKZfDTOU/";
      keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqKYXW07z0llbDKRIakLD1PjHe3HxK9iu6czXs+ZU7v"];
      extraOptions = {};
      extraGroups = [];
    };
  };

  networking = {
    hostName = "mini";
  };

  environment.variables = {
    PROMPT = "%m@%n> ";
    RPROMPT = "%D %T";
  };

  nix.settings.trusted-users = ["@wheel"]; # need for remote build
}
