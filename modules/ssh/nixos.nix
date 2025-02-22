{ pkgs, ... }:
{
  services.openssh = {
    enable = true;

    settings = {
      X11Forwarding = true;
    };
  };

  environment.systemPackages = with pkgs; [ waypipe ];

  networking.firewall = {
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ 22 ];
  };
}
