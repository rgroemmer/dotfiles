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
      url = "github:rgroemmer/neonix/pre-release-0.1.0";
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

    # NOTE: Try a new browser (firefox based 🧋)
    zen-browser = {
      url = "github:marcecoll/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    pre-commit-hooks,
    ...
  }: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;

    systems = ["aarch64-darwin" "x86_64-linux"];
    pkgsFor = lib.genAttrs systems (system: import nixpkgs {inherit system;});
    forAllSystems = f: lib.genAttrs systems (system: f pkgsFor.${system});
  in {
    inherit lib;

    formatter = forAllSystems (pkgs: pkgs.alejandra);
    devShells = forAllSystems (pkgs: import ./shell.nix {inherit pkgs pre-commit-hooks;});

    nixosConfigurations = {
      # Main workstation
      zion = lib.nixosSystem {
        modules = [./hosts/zion];
        specialArgs = {inherit inputs outputs;};
      };
      # K3S home-lab
      k3s-m0 = lib.nixosSystem {
        modules = [./hosts/k3s-m0];
        specialArgs = {inherit inputs outputs;};
      };
      k3s-m1 = lib.nixosSystem {
        modules = [./hosts/k3s-m1];
        specialArgs = {inherit inputs outputs;};
      };
      k3s-m2 = lib.nixosSystem {
        modules = [./hosts/k3s-m2];
        specialArgs = {inherit inputs outputs;};
      };
      # Iso's
      installer-iso = lib.nixosSystem {
        modules = [./hosts/installer-iso];
        specialArgs = {inherit inputs outputs;};
      };
    };

    homeConfigurations = {
      # Main workstation
      "rap@zion" = lib.homeManagerConfiguration {
        modules = [./home-manager/zion.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
      # Apple macbook work-device
      "groemmer@intoshi" = lib.homeManagerConfiguration {
        modules = [./home-manager/intoshi.nix];
        pkgs = pkgsFor.aarch64-darwin;
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  };
}
