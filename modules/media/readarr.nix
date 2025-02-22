{ ... }:
{
  services.readarr.enable = true;

  services.caddy.virtualHosts.readarr = {
    serverAliases = [
      "http://readarr.local"
      "http://library.local"
      "http://books.local"
    ];

    extraConfig = "reverse_proxy * localhost:8787";
  };

  networking.hosts."127.0.0.1" = [
    "readarr.local"
    "library.local"
    "books.local"
  ];
}
