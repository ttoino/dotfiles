{ config, lib, ... }:
{
  networking.firewall.interfaces = {
    eth0 = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };

    wg0 = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };
  };

  services.dnsmasq = {
    enable = true;

    settings = {
      bind-dynamic = true;
      interface = [
        "eth0"
        "wg0"
        "lo"
      ];
      localise-queries = true;

      server = [
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
        "8.8.4.4"
      ];
    };
  };

  services.resolved.enable = false;
}
