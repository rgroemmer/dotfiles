{
  description = "Rap's system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # custom flakes
    neovim.url = "github:rgroemmer/neovim";
  };

  outputs = { nixpkgs, home-manager, darwin, ... }@inputs:
    let
      nixpkgsConfig = {
        allowUnfree = true;
        allowUnsupportedSystem = false;
        allowBroken = true;
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

      overlays = with inputs; [
        neovim.overlay
      ];
    in {

      # nix-darwin with home-manager for macOS
      darwinConfigurations."SIT-SMBP-91HWJ1" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        # makes all inputs availble in imported files
        specialArgs = { inherit inputs; };
        modules = [
          ./macos
          ({ pkgs, ... }: {
            nixpkgs.config = nixpkgsConfig;
            nix.useDaemon = true;
            system.stateVersion = 4;

            users.users."groemmer" = {
              home = "/Users/groemmer";
              shell = pkgs.zsh;
            };
          })

          home-manager.darwinModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # makes all inputs available in imported files for hm
              extraSpecialArgs = { inherit inputs; };
              users."groemmer" = { ... }: {
                imports = [
                  ./home/shell
                  ./macos/yabai.nix
                ];
                home.stateVersion = stateVersion;
              };
            };
          }
        ];
      };

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

#            nixpkgs.overlays = overlays;

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
