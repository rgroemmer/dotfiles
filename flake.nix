{
  description = "Nix Schmix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grub-theme = {
      url = "github:catppuccin/grub";
      flake = false;
    };

    hyprland-git = {
      url = "github:hyprwm/hyprland";
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

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    pre-commit-hooks,
    disko,
    ...
  }: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    systems = ["aarch64-darwin" "x86_64-linux"];
    pkgsFor = system: import nixpkgs {inherit system;};
    forAllSystems = f: lib.genAttrs systems (system: f (pkgsFor system));
  in {
    inherit lib;

    nixosConfigurations = {
      # Main workstation
      zion = lib.nixosSystem {
        modules = [./systems/x86_64-linux/zion];
        specialArgs = {inherit inputs outputs;};
      };
      # K3S home-lab
      k3s-m0 = lib.nixosSystem {
        modules = [./hosts/k3s-m0];
        specialArgs = {inherit inputs outputs;};
      };
      k3s-m1 = lib.nixosSystem {
        modules = [./hosts/k3s-m1];
        specialArgs = {inherit inputs outputs lib;};
      };
      k3s-m2 = lib.nixosSystem {
        modules = [./hosts/k3s-m2];
        specialArgs = {inherit inputs outputs lib;};
      };
      # Iso installer
      installer = lib.nixosSystem {
        modules = [./systems/isos/installer];
        specialArgs = {inherit inputs outputs lib;};
      };
    };

    homeConfigurations = {
      # Main workstation
      "rap@zion" = lib.homeManagerConfiguration {
        modules = [./systems/x86_64-linux/zion/home.nix];
        extraSpecialArgs = {inherit inputs outputs;};
      };
      # Macbook 4 work
      workintosh = lib.homeManagerConfiguration {
        modules = [./systems/aarch64-darwin/workintosh/home.nix];
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };

    formatter = forAllSystems (pkgs: pkgs.alejandra);

    # TODO: use import and move to file
    checks = forAllSystems (pkgs: {
      pre-commit-check = pre-commit-hooks.lib.${pkgs.system}.run {
        src = ./.;
        hooks = {
          statix.enable = true;
          alejandra.enable = true;
          deadnix.enable = true;
        };
      };
    });

    devShells = forAllSystems (pkgs: {
      default = with pkgs;
        mkShell {
          inherit (self.checks.${pkgs.system}.pre-commit-check) shellHook;

          packages = [
            nh
            statix
            deadnix
            alejandra
            nix-inspect
          ];
        };
    });
  };
}
