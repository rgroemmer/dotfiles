{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [kubectl];

  services.k3s = {
    enable = true;
    role = "server";
    package = pkgs.k3s_1_31;
    token = "changeme!";
  };
}
