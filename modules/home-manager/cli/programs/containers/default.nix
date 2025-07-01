{pkgs, ...}: {
  imports = [
    ./k9s.nix
    ./k9s-plugins.nix
    ./krewfile.nix
  ];

  home.packages = with pkgs; [
    # OCI tooling
    podman-tui
    docker-compose
    dive
    crane

    # Kubernetes tooling
    kubectl
    kubernetes-helm
    fluxcd
  ];
}
