{
    description = "Rap's system configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, discord, ... }@inputs:
    let
        nixpkgsConfig = {
            allowUnfree = true;
            allowUnsupportedSystem = false;
        };
        stateVersion = "21.11";
        user = "rap";

        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [];
        };
	in {
        nixosConfigurations = {
            rapos = nixpkgs.nixosSystem {
					inherit system pkgs;
					modules = [
						./configuration.nix
						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = false;
							home-manager.users.rap = import ./home.nix;
						}
					];
				};
            };
		};
}
