{ ... }:
{
  services.lidarr = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts.lidarr = {
    serverAliases = [
      "https://lidarr.local"
      "https://music.local"
      "https://songs.local"
    ];

    extraConfig = "reverse_proxy * localhost:8686";
  };

  networking.hosts."127.0.0.1" = [
    "lidarr.local"
    "music.local"
    "songs.local"
  ];
}
