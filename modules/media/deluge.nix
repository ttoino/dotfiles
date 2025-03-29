{ config, ... }:
{
  services.deluge = {
    enable = true;
    group = "media";

    web.enable = true;
    declarative = true;
    authFile = config.age.secrets.deluge-auth.path;

    config = {
      dont_count_slow_torrents = true;
      download_location = "/data/downloads/torrents";
      max_active_downloading = 10;
      max_active_limit = 10;
      max_active_seeding = 1;
      max_connections_global = -1;
      sequential_download = true;
    };
  };

  services.caddy.virtualHosts."torrents.toino.pt".extraConfig = "reverse_proxy * localhost:8112";

  networking.hosts."127.0.0.1" = [
    "torrents.toino.pt"
  ];

  age.secrets.deluge-auth = {
    rekeyFile = ./deluge_auth.age;
    owner = config.services.deluge.user;
    group = config.services.deluge.group;
  };
}
