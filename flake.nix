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

    # TODO: Add docs to nixGL, -> `hardware.graphics.enable = true`, configured openGL for nixOS, this is lost on
    # ubuntu, so programs using graphics card, will not find the necessarry drivers.
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-git = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    neonix = {
      url = "github:rgroemmer/neonix/fine-tuning";
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
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
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
    devShells = forAllSystems (pkgs: import ./dev-shells.nix {inherit pkgs pre-commit-hooks;});
    packages = forAllSystems (pkgs: import ./packages {inherit pkgs;});

    nixosConfigurations = {
      # Main workstation
      zion = lib.nixosSystem {
        modules = [./hosts/zion];
        specialArgs = {inherit inputs outputs;};
      };
      # K3S home-lab
      kubex = lib.nixosSystem {
        modules = [./hosts/kubex];
        specialArgs = {inherit inputs outputs;};
      };
      # Raspberry-pi 3
      nixberry = lib.nixosSystem {
        system = "aarch64-linux";
        modules = [./hosts/nixberry];
        specialArgs = {inherit inputs;};
      };
      # Minimal system for remote install
      mini = lib.nixosSystem {
        modules = [./hosts/mini];
        specialArgs = {inherit inputs outputs;};
      };
      # ISO multi-tool
      vinox = lib.nixosSystem {
        modules = [./hosts/vinox];
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
        extraSpecialArgs = {inherit self inputs outputs;};
      };
      # Apple macbook work-device
      "raphael.groemmer@stackit.cloud@firefly" = lib.homeManagerConfiguration {
        modules = [./home-manager/firefly.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit self inputs outputs;};
      };
    };
  };
}
