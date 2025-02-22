{ ... }:
{
  services.jellyfin.enable = true;

  services.caddy.virtualHosts.jellyfin = {
    serverAliases = [
      "http://jellyfin.local"
      "http://watch.local"
    ];

    extraConfig = "reverse_proxy * localhost:8096";
  };

  networking.hosts."127.0.0.1" = [
    "jellyfin.local"
    "watch.local"
  ];
}
