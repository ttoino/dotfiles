{ pkgs, ... }:
{
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [ waypipe ];

  networking.firewall.allowedTCPPorts = [ 22 ];
}
