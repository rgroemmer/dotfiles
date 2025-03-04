{pkgs, ...}: {
  home.packages = with pkgs; [
    dive
    crane
    docker-compose
    podman-tui
  ];
}
