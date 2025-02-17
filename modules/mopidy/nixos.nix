{ ... }:
{
  networking.hosts."127.0.0.1" = [
    "mopidy.local"
    "listen.local"
  ];

  services.caddy.virtualHosts.mopidy = {
    serverAliases = [
      "mopidy.local"
      "listen.local"
    ];

    extraConfig = "reverse_proxy * localhost:6680/iris";
  };
}
