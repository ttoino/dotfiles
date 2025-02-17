{ ... }:
{
  services.sonarr.enable = true;

  services.caddy.virtualHosts.sonarr = {
    serverAliases = [
      "sonarr.local"
      "tv.local"
      "shows.local"
      "series.local"
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
