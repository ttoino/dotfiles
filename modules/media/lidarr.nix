{ pkgs, ... }:
{
  services.lidarr = {
    package = pkgs.lidarr-plugins;
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts."music.toino.pt".extraConfig = "reverse_proxy * localhost:8686";

  networking.hosts."127.0.0.1" = [ "music.toino.pt" ];
}
