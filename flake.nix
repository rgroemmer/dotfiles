{
  description = "RAPSN Nixos Configuration";
  
  inputs = {
	  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

	outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      nixpkgsConfig = {
          allowUnfree = true;
          allowUnsupportedSystem = false;
      };
      stateVersion = "21.11";
      user = "rap";
      system = "x86_64-linux";

      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [];
      };
	in {
    nixosConfigurations.rapos = lib.nixosSystem {
      inherit system pkgs;

      # make inputs available in imported files
      specialArgs = { inherit inputs; inherit user; }
      modules = [
        ./configuration.nix
        home-manager.nixosModule {
          home-manager = {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.users.rap = import ./home.nix;
          }
        }
      ];
    };
  };
}
