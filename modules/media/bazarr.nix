{ ... }:
{
  services.bazarr.enable = true;

  services.caddy.virtualHosts.bazarr = {
    serverAliases = [
      "bazarr.local"
      "captions.local"
      "subtitles.local"
    ];

    extraConfig = "reverse_proxy * localhost:6767";
  };

  networking.hosts."127.0.0.1" = [
    "bazarr.local"
    "captions.local"
    "subtitles.local"
  ];
}
