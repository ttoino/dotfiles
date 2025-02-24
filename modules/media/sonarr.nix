{ ... }:
{
  services.sonarr = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts.sonarr = {
    serverAliases = [
      "https://sonarr.local"
      "https://tv.local"
      "https://shows.local"
      "https://series.local"
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
