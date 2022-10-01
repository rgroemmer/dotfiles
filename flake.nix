{
	description = "Rap's system configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		discord = {
			type = "tarball";
			url = "https://discord.com/api/download/stable?platform=linux&format=tar.gz";
			flake = false;
		};
	};

	outputs = { self, nixpkgs, home-manager, discord, ... }@inputs:
		let
			nixpkgsConfig = {
				allowUnfree = true;
				allowUnsupportedSystem = false;
			};
			stateVersion = "21.11";
			user = "rap";


			# system = "x86_64-linux";
			# pkgs = import nixpkgs {
			# 	inherit system discord;
			# 	config.allowUnfree = true;
			# 	overlays = [
			# 		(final: prev: {
			# 			nix-direnv = prev.nix-direnv.override { enableFlakes = true; };
			# 			discord = prev.discord.overrideAttrs (
			# 				_: { src = inputs.discord; }
			# 			);
			# 		})
			# 	];
			# };
			# 
		in 
		{
			nixosConfigurations = 
        		let
					system = "x86_64-linux";
					# modifies pkgs to allow unfree packages
					pkgs = import nixpkgs {
						inherit system;
						config = nixpkgsConfig;
					};
					lib = nixpkgs.lib;
		  	in
			lib.nixosSystem {
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
}
