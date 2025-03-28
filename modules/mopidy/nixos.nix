{ ... }:
{
  networking.hosts."127.0.0.1" = [ "listen.toino.pt" ];

  services.caddy.virtualHosts."listen.toino.pt".extraConfig = "reverse_proxy * localhost:6680";
}
