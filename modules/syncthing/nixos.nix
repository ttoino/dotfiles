{ ... }:
{
  networking.firewall.interfaces.wg0 = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [
      22000
      21027
    ];
  };

  services.caddy.virtualHosts."sync.toino.pt".extraConfig = ''
    reverse_proxy * localhost:8384 {
      header_up Host localhost
    }
  '';
  networking.hosts."127.0.0.1" = [ "sync.toino.pt" ];
}
