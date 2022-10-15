{
  description = "Rap's system configuration";

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

      system = "x86_64-linux";
      stateVersion = "22.05";
      user = "rap";

      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ ];
      };
    in {
      nixosConfigurations.rapos = lib.nixosSystem {
        inherit system;

        # specialArgs is an argument which nix will inject in every import / module, thats why "{ ..., } is needed.
        # to make user available in all imports
        specialArgs = { inherit user; };

        modules = [
          ./machines/linux.nix
          ./system

          # like a module import but inline use "()" because only "{}" is not valid syntax
          ({ pkgs, ... }: {

            system.stateVersion = stateVersion;
            nixpkgs.config = nixpkgsConfig;

            users.users.${user} = {
              home = "/home/${user}";
              shell = pkgs.zsh;
              isNormalUser = true;
            };

            nix.settings.experimental-features = [ "nix-command" "flakes" ];
          })

          home-manager.nixosModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.${user} = { ... }: {
                imports = [ ./home ];
                home.stateVersion = stateVersion;
              };
            };
          }
        ];

      };
    };
}
