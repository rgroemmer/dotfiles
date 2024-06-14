{
  description = "Nix Schmix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin.url = "github:lnl7/nix-darwin";
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
      url = "github:rgroemmer/neonix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    krewfile = {
      url = "github:brumhard/krewfile";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # TODO:
    # nwg-displays.url = "github:nwg-piotr/nwg-displays/master";
    # nix attic
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      darwin,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib // darwin.lib;
    in
    {
      inherit lib;
      stateVersion = "22.05";

      nixosConfigurations.zion = lib.nixosSystem {
        modules = [ ./hosts/zion/configuration.nix ];
        specialArgs = {
          inherit inputs outputs;
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
        SIT-SMBP-91HWJ1 = lib.homeManagerConfiguration {
          modules = [ ./hosts/macbook/home.nix ];
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };
      };

      # Macbook
      darwinConfigurations.SIT-SMBP-91HWJ1 = darwin.lib.darwinSystem {
        system = "aarch64-dawin";
        modules = [ ./hosts/macbook/home.nix ];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };
}
