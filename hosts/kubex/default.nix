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
      name = "kubex";
      initialHashedPassword = "$y$j9T$8uQSJbY6w9kjXnj74JKjA1$pWYgNf.gb497suX//oIw6aggEPoD2Xv1kvMKZfDTOU/";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqKYXW07z0llbDKRIakLD1PjHe3HxK9iu6czXs+ZU7v";
      extraOptions = {};
      extraGroups = [];
    };
    modules.k3s = {
      enable = true;
      clusterInit = true; # Only for initial bootstrap
    };
  };

  networking = {
    defaultGateway = "192.168.55.1";
    nameservers = [
      "192.168.55.1"
    ];
    hostName = "kubex_00";
    hostId = "5851308f";
    interfaces.ens18.ipv4.addresses = [
      {
        address = "192.168.55.50";
        prefixLength = 24;
      }
    ];
  };

  environment.variables = {
    PROMPT = "%m@%n> ";
    RPROMPT = "%D %T";
  };

  nix.settings.trusted-users = ["@wheel"]; # need for remote build
}
