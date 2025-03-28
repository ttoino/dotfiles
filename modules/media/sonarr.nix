{ ... }:
{
  services.sonarr = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts."shows.toino.pt".extraConfig = "reverse_proxy * localhost:8989";

  networking.hosts."127.0.0.1" = [ "shows.toino.pt" ];
}
