{ ... }:
{
  services.bazarr = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts.bazarr = {
    serverAliases = [
      "https://bazarr.local"
      "https://captions.local"
      "https://subtitles.local"
    ];

    extraConfig = "reverse_proxy * localhost:6767";
  };

  networking.hosts."127.0.0.1" = [
    "bazarr.local"
    "captions.local"
    "subtitles.local"
  ];
}
