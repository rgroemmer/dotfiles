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
          lib = nix-darwin.lib // home-manager.lib // nixpkgs.lib;

          mkNode =
            { name, address }:
            lib.nixosSystem {
              modules = [
                ./systems/x86_64-linux/k3s/configuration.nix
                disko.nixosModules.disko
              ];
              specialArgs = {
                inherit name address;
              };
            };

          inherit (self) outputs;
        in
        {
          stateVersion = "22.05";

          nixosConfigurations = {

            zion = lib.nixosSystem {
              modules = [ ./systems/x86_64-linux/zion/configuration.nix ];
              specialArgs = {
                inherit inputs outputs;
              };
            };

            k3s-m0 = mkNode {
              name = "k3s-m0";
              address = "192.168.55.20";
            };
            k3s-m1 = mkNode {
              name = "k3s-m1";
              address = "192.168.55.30";
            };
            k3s-m2 = mkNode {
              name = "k3s-m2";
              address = "192.168.55.40";
            };

            installer-iso = lib.nixosSystem {
              system = "x86_64-linux";
              modules = [
                "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
                "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
                ./systems/x86_64-linux-isos/installer/installer.nix
              ];
            };

          };

          homeConfigurations = {

            "rap@zion" = lib.homeManagerConfiguration {
              modules = [ ./systems/x86_64-linux/zion/home.nix ];
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

                packages = [
                  nh
                  statix
                  deadnix
                ];
              };
          };

        };
    };
}
