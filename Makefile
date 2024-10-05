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
	@sudo nix run 'github:nix-community/disko#disko-install' -- --flake .#kube-node --disk local /dev/sda
