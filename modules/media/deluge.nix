{ config, ... }:
{
  services.deluge = {
    enable = true;

    web.enable = true;
    declarative = true;
    config.download_location = "/data/downloads/torrents";
    authFile = config.age.secrets.deluge-auth.path;
  };

  services.caddy.virtualHosts.deluge = {
    serverAliases = [
      "http://deluge.local"
      "http://torrent.local"
    ];

    extraConfig = "reverse_proxy * localhost:8112";
  };

  networking.hosts."127.0.0.1" = [
    "deluge.local"
    "torrent.local"
  ];

  age.secrets.deluge-auth = {
    rekeyFile = ./deluge_auth.age;
    owner = config.services.deluge.user;
    group = config.services.deluge.group;
  };
}
