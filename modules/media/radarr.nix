{ ... }:
{
  services.radarr = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts.radarr = {
    serverAliases = [
      "https://radarr.local"
      "https://cinema.local"
      "https://movies.local"
    ];

    extraConfig = "reverse_proxy * localhost:7878";
  };

  networking.hosts."127.0.0.1" = [
    "radarr.local"
    "cinema.local"
    "movies.local"
  ];
}
