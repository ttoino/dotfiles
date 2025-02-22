{ ... }:
{
  services.sonarr.enable = true;

  services.caddy.virtualHosts.sonarr = {
    serverAliases = [
      "http://sonarr.local"
      "http://tv.local"
      "http://shows.local"
      "http://series.local"
    ];

    extraConfig = "reverse_proxy * localhost:8989";
  };

  networking.hosts."127.0.0.1" = [
    "sonarr.local"
    "tv.local"
    "shows.local"
    "series.local"
  ];
}
