{
  description = "Nix Schmix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin.url = "github:lnl7/nix-darwin";
    grub-theme = {
      url = "github:catppuccin/grub";
      flake = false;
    };

    hyprland-git.url = "github:hyprwm/hyprland";

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";

    neonix = {
      url = "github:rgroemmer/neonix/the-little-things";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    krewfile = {
      url = "github:brumhard/krewfile";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO:
    # nwg-displays.url = "github:nwg-piotr/nwg-displays/master";
    # testing
    # nix attic

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    flake-parts.url = "github:hercules-ci/flake-parts";
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

          nixosConfigurations.iso = lib.nixosSystem {
            modules = [
              "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
              "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
              ./iso/configuration.nix
            ];
          };

          nixosConfigurations.master = lib.nixosSystem {
            modules = [
              ./hosts/kube-node/configuration.nix { k8sRole = "master"; }
              disko.nixosModules.disko
            ];
          };

          nixosConfigurations.secondary = lib.nixosSystem {
            modules = [
              ./hosts/kube-node/configuration.nix
              disko.nixosModules.disko
            ];
          };

        };

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
        "aarch64-linux"
      ];

      perSystem =
        let
          flakeDir = builtins.toString (builtins.toString self);
        in
        { config, pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            builtInputs = with pkgs; [ nixfmt-rfc-style ];
            shellHook = ''
              echo " asdölfkjasdölfj ${flakeDir}"
            '';
          };
        };
    };
}
