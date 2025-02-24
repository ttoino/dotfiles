{ ... }:
{
  services.readarr = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts.readarr = {
    serverAliases = [
      "https://readarr.local"
      "https://library.local"
      "https://books.local"
    ];

    extraConfig = "reverse_proxy * localhost:8787";
  };

  networking.hosts."127.0.0.1" = [
    "readarr.local"
    "library.local"
    "books.local"
  ];
}
