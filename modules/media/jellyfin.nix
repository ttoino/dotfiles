{ ... }:
{
  services.jellyfin = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts.jellyfin = {
    serverAliases = [
      "https://jellyfin.local"
      "https://watch.local"
    ];

    extraConfig = "reverse_proxy * localhost:8096";
  };

  networking.hosts."127.0.0.1" = [
    "jellyfin.local"
    "watch.local"
  ];
}
