{ ... }:
{
  networking.hosts."127.0.0.1" = [ "listen.toino.pt" ];

  # https://github.com/jaedb/Iris/wiki/Advanced#encryption-httpswss
  services.caddy.virtualHosts."listen.toino.pt".extraConfig = ''
    reverse_proxy * localhost:6680
    redir / /iris
  '';
}
