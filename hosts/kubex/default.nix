{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ../../nixos

    inputs.disko.nixosModules.disko
  ];
  # Host specific configuration
  system = {
    boot = {
      systemd = true;
      supportedFilesystems = ["zfs"];
    };
    user = {
      name = "kubex";
      initialHashedPassword = "$y$j9T$8uQSJbY6w9kjXnj74JKjA1$pWYgNf.gb497suX//oIw6aggEPoD2Xv1kvMKZfDTOU/";
      key = [
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKX8MmA9KdHCny6rKCGZlyd/J5qCXh+YDM0/3ZGDmfyaAAAABHNzaDo= yubi@rapsn.me"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGqKYXW07z0llbDKRIakLD1PjHe3HxK9iu6czXs+ZU7v techkey@rapsn"
      ];
      extraOptions = {};
      extraGroups = [];
    };
    modules = {
      k3s = true;
    };
  };

  # Secrets for host
  sops.secrets.zfs-encryption-key = {
    sopsFile = ./secrets.yaml;
    path = "/tmp/zfs-encryption-key";
  };

  networking = {
    defaultGateway = "192.168.55.1";
    nameservers = [
      "192.168.55.1"
    ];
    hostName = "kubex";
    hostId = "5851308f";
    interfaces.enp8s0.ipv4.addresses = [
      {
        address = "192.168.55.10";
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
