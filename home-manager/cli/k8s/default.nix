{pkgs, ...}: {
  imports = [
    ./k9s.nix
    ./krewfile.nix
  ];

  home.packages = with pkgs; [
    kubectl
    kubernetes-helm
    fluxcd
  ];
}