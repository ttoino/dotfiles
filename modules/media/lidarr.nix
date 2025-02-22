{ ... }:
{
  services.lidarr.enable = true;

  services.caddy.virtualHosts.lidarr = {
    serverAliases = [
      "http://lidarr.local"
      "http://music.local"
      "http://songs.local"
    ];

    extraConfig = "reverse_proxy * localhost:6767";
  };

  networking.hosts."127.0.0.1" = [
    "lidarr.local"
    "music.local"
    "songs.local"
  ];
}
