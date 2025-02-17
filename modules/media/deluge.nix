{ ... }:
{
  services.deluge.enable = true;

  services.caddy.virtualHosts.deluge = {
    serverAliases = [
      "deluge.local"
      "torrent.local"
    ];

    extraConfig = "reverse_proxy * localhost:8112";
  };

  networking.hosts."127.0.0.1" = [
    "deluge.local"
    "torrent.local"
  ];
}
