{
  description = "Nix Schmix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim.url = "github:rgroemmer/neovim";
    darwin.url = "github:lnl7/nix-darwin";
    grub-theme = {
      url = "github:catppuccin/grub";
      flake = false;
    };
    nix-colors.url = "github:misterio77/nix-colors";
    hyprland-nix.url = "github:spikespaz/hyprland-nix";
    hypr-contrib.url = "github:hyprwm/contrib";
    sops-nix.url = "github:mic92/sops-nix";
    #TODO: impermanence.url = "github:nix-community/impermanence";
    nwg-displays.url = "github:nwg-piotr/nwg-displays/master";
    nix-gaming.url = "github:fufexan/nix-gaming";
    #TODO: nix attic
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib // darwin.lib;
      packages = (pkgs: import ./pkgs { inherit pkgs; });
    in {
      inherit lib;
      stateVersion = "22.05";

      # Main desktop
      nixosConfigurations.zion = lib.nixosSystem {
        modules = [ ./hosts/zion/configuration.nix ];
        specialArgs = { inherit inputs outputs; };
      };

      homeConfigurations = {
        # zion
        zion = lib.homeManagerConfiguration {
          modules = [ ./hosts/zion/home.nix ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        # Devbox
        devbox = lib.homeManagerConfiguration {
          modules = [ ./hosts/devbox/home.nix ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };

      # Macbook
      darwinConfigurations.macbook = lib.darwinSystem {
        modules = [ ./hosts/macbook/home.nix ];
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };
}
