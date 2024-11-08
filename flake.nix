{
  description = "Nix Schmix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
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
    catppuccin.url = "github:catppuccin/nix";

    # TODO:
    # nwg-displays.url = "github:nwg-piotr/nwg-displays/master";
    # testing
    # nix attic
  };

  outputs =
    inputs@ # alias for the entire input attrs
    {
      self,
      nixpkgs,
      home-manager,
      pre-commit-hooks,
      disko,
      ...
    }:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;

      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];
      pkgsFor = system: import nixpkgs { inherit system; };
      forAllSystems = f: lib.genAttrs systems (system: f (pkgsFor system));
    in
    #mylib = import ./lib.nix;
    #lib = nix-darwin.lib // home-manager.lib // nixpkgs.lib // mylib { inherit (nixpkgs) lib; };
    {
      inherit lib;

      nixosConfigurations = {
        zion = lib.nixosSystem {
          modules = [ ./systems/x86_64-linux/zion ];
          specialArgs = {
            inherit inputs outputs;
          };
        };

        k3s-m0 = lib.nixosSystem {
          modules = [
            ./systems/x86_64-linux/k3s
            ./modules/nixos/common
            ./modules/nixos/k3s
            disko.nixosModules.disko
          ];
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

      checks = forAllSystems (pkgs: {
        pre-commit-check = pre-commit-hooks.lib.${pkgs.system}.run {
          src = ./.;
          hooks = {
            statix.enable = true;
            nixfmt-rfc-style.enable = true;
            deadnix.enable = true;
          };
        };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      devShells = forAllSystems (pkgs: {
        default =
          with pkgs;
          mkShell {
            inherit (self.checks.${pkgs.system}.pre-commit-check) shellHook;

            packages = [
              nh
              statix
              deadnix
              nix-inspect
            ];
          };
      });
    };
}
