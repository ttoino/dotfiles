{ ... }:
{
  services.readarr = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts."books.toino.pt".extraConfig =
    "reverse_proxy * localhost:8787";

  networking.hosts."127.0.0.1" = [ "books.toino.pt" ];
}
