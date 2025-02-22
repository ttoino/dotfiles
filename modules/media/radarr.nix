{ ... }:
{
  services.radarr.enable = true;

  services.caddy.virtualHosts.radarr = {
    serverAliases = [
      "http://radarr.local"
      "http://cinema.local"
      "http://movies.local"
    ];

    extraConfig = "reverse_proxy * localhost:7878";
  };

  networking.hosts."127.0.0.1" = [
    "radarr.local"
    "cinema.local"
    "movies.local"
  ];
}
