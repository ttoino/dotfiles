{ ... }:
{
  services.jellyfin = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts."watch.toino.pt".extraConfig =
    "reverse_proxy * localhost:8096";

  networking.hosts."127.0.0.1" = [ "watch.toino.pt" ];
}
