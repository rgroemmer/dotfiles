.PHONY: switch
switch:
	@sudo nixos-rebuild switch --flake '.#zion'

.PHONY: up
up:
	@nix flake update

.PHONY: mac
mac:
	@nix run nix-darwin -- switch --flake .\#macbook

.PHONY: fmt
fmt:
	@find . -name '*.nix' -not -path './.direnv/*' -exec nixfmt {} \;

.PHONY: install-k8s
install-k8s:
	nix run github:nix-community/disko --no-write-lock-file -- --mode zap_create_mount ./hosts/kube-node/disko.nix
	nixos-install --flake .#kube-node
