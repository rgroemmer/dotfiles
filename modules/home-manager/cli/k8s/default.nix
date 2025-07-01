{pkgs, ...}: {
  imports = [
    ./k9s.nix
    ./k9s-plugins.nix
    ./krewfile.nix
  ];

  home.packages = with pkgs; [
    kubectl
    kubernetes-helm
    fluxcd
  ];
}
