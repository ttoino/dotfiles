{ ... }:
{
  services.prowlarr.enable = true;

  services.caddy.virtualHosts.prowlarr = {
    serverAliases = [
      "prowlarr.local"
      "trackers.local"
    ];

    extraConfig = "reverse_proxy * localhost:9696";
  };

  networking.hosts."127.0.0.1" = [
    "prowlarr.local"
    "trackers.local"
  ];
}
