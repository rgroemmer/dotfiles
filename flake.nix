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

          nixosConfigurations.zion = lib.nixosSystem {
            modules = [ ./hosts/zion/configuration.nix ];
            specialArgs = {
              inherit inputs outputs;
            };
          };

          nixosConfigurations.iso = lib.nixosSystem {
            modules = [
              "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
              "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
              ./iso/configuration.nix
            ];
          };

          nixosConfigurations.k3s-master = lib.nixosSystem {
            modules = [
              ./hosts/kube-node/configuration.nix
              disko.nixosModules.disko
            ];
            specialArgs = {
              role = "master";
            };
          };

          nixosConfigurations.k3s-node = lib.nixosSystem {
            modules = [
              ./hosts/kube-node/configuration.nix
              disko.nixosModules.disko
            ];
          };

          homeConfigurations.zion = lib.homeManagerConfiguration {
            modules = [ ./hosts/zion/home.nix ];
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {
              inherit inputs outputs;
            };
          };

          darwinConfigurations.macbook = lib.darwinSystem {
            modules = [ ./hosts/macbook/configuration.nix ];
            pkgs = nixpkgs.legacyPackages.aarch64-darwin;
            specialArgs = {
              inherit inputs outputs;
            };
          };
        };

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        { config, pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              git
              nixfmt-rfc-style
              treefmt
              yamlfmt
              nh
            ];
            shellHook = ''
              export FLAKE="$PWD"
              alias fmt="treefmt --tree-root=."
              treefmt --tree-root=.
            '';
          };
        };
    };
}
