.PHONY: switch
switch:
	@ARG=$(filter-out $@,$(MAKECMDGOALS)); \
	if [[ -z "$$ARG" ]]; then ARG="zion"; fi; \
	sudo nixos-rebuild switch --flake ".#$$ARG"

.PHONY: install
install:
	@ARG=$(filter-out $@,$(MAKECMDGOALS)); \
	nix run github:nix-community/disko --no-write-lock-file -- --mode zap_create_mount ./hosts/$$ARG/disko.nix
	nixos-install --flake ".#$$ARG"

.PHONY: iso
iso:
	nix build .#nixosConfigurations.iso.config.system.build.isoImage

.PHONY: up
up:
	@nix flake update

.PHONY: mac
mac:
	@nix run nix-darwin -- switch --flake .\#macbook

