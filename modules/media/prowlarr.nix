{ ... }:
{
  services.prowlarr.enable = true;

  services.caddy.virtualHosts."trackers.toino.pt".extraConfig =
    "reverse_proxy * localhost:9696";

  networking.hosts."127.0.0.1" = [ "trackers.toino.pt" ];
}
