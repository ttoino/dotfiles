{ ... }:
{
  services.caddy.virtualHosts."opencode.toino.pt".extraConfig = "reverse_proxy * localhost:9090";

  networking.hosts."127.0.0.1" = [ "opencode.toino.pt" ];
}
