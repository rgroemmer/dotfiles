.PHONY: switch
switch:
	@sudo nixos-rebuild switch --flake '.#zion'

.PHONY: up
up:
	@nix flake update

.PHONY: fmt
fmt:
	@find . -name '*.nix' -not -path './.direnv/*' -exec nixfmt {} \;
