TARGETS := switch install build

# Argument extraction (filtering out all known targets)
ARG := $(firstword $(filter-out $(TARGETS),$(MAKECMDGOALS)))

# Ensure ARG is set, fallback to "zion" if not provided
define ensure_arg
	@if [ -z "$(ARG)" ]; then \
		ARG="zion"; \
	fi
endef

.PHONY: switch
switch:
	$(call get_arg)
	sudo nixos-rebuild switch --flake ".#$(ARG)"

.PHONY: install
install:
	$(call get_arg)
	nix run github:nix-community/disko --no-write-lock-file -- --mode zap_create_mount ./hosts/$(ARG)/disko.nix
	nixos-install --flake ".#$(ARG)"

.PHONY: build
build:
	$(call get_arg)
	sudo nixos-rebuild build --flake ".#$(ARG)"

.PHONY: iso
iso:
	nix build .#nixosConfigurations.iso.config.system.build.isoImage

.PHONY: up
up:
	@nix flake update

.PHONY: mac
mac:
	@nix run nix-darwin -- switch --flake .\#macbook

%:
	@:
