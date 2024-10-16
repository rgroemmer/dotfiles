{
  description = "Nix Schmix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-git = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neonix = {
      url = "github:rgroemmer/neonix/the-little-things";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    krewfile = {
      url = "github:brumhard/krewfile";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grub-theme = {
      url = "github:catppuccin/grub";
      flake = false;
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    catppuccin.url = "github:catppuccin/nix";

    # TODO:
    # nwg-displays.url = "github:nwg-piotr/nwg-displays/master";
    # testing
    # nix attic
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      flake-parts,
      pre-commit-hooks,
      disko,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {

      flake =
        let
          lib = nixpkgs.lib // home-manager.lib // nix-darwin.lib;
          inherit (self) outputs;
        in
        {
          stateVersion = "22.05";

          nixosConfigurations = {

            zion = lib.nixosSystem {
              modules = [ ./hosts/zion/configuration.nix ];
              specialArgs = {
                inherit inputs outputs;
              };
            };

            k3s-m0 = lib.nixosSystem {
              modules = [
                ./hosts/k3s-m0/configuration.nix
                disko.nixosModules.disko
              ];
            };

            k3s-m1 = lib.nixosSystem {
              modules = [
                ./hosts/k3s-m1/configuration.nix
                disko.nixosModules.disko
              ];
              specialArgs = {
                role = "server";
                addresses = [
                  {
                    address = "192.168.55.30";
                    prefixLength = 24;
                  }
                ];
              };
            };

            k3s-m2 = lib.nixosSystem {
              modules = [
                ./hosts/k3s-m2/configuration.nix
                disko.nixosModules.disko
              ];
              specialArgs = {
                role = "server";
                addresses = [
                  {
                    address = "192.168.55.31";
                    prefixLength = 24;
                  }
                ];
              };
            };

            iso = lib.nixosSystem {
              modules = [
                "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
                "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
                ./iso/configuration.nix
              ];
            };
          };

          homeConfigurations = {

            zion = lib.homeManagerConfiguration {
              modules = [ ./hosts/zion/home.nix ];
              pkgs = nixpkgs.legacyPackages.x86_64-linux;
              extraSpecialArgs = {
                inherit inputs outputs;
              };
            };

            workintosh = lib.homeManagerConfiguration {
              modules = [ ./systems/aarch64-darwin/workintosh/home.nix ];
              pkgs = nixpkgs.legacyPackages.aarch64-darwin;
              extraSpecialArgs = {
                inherit inputs outputs;
              };
            };
          };
        };

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        {
          pkgs,
          system,
          self',
          ...
        }:
        {
          checks = {
            pre-commit-check = pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                statix.enable = true;
                nixfmt-rfc-style.enable = true;
                deadnix.enable = true;
              };
            };
          };

          formatter = pkgs.nixfmt-rfc-style;

          devShells = {
            default =
              with pkgs;
              mkShell {
                inherit (self'.checks.pre-commit-check) shellHook;
                packages = [ nh ];
              };
          };

        };
    };
}
