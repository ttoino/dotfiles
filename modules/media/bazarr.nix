{ ... }:
{
  services.bazarr = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts."captions.toino.pt".extraConfig =
    "reverse_proxy * localhost:6767";

  networking.hosts."127.0.0.1" = [ "captions.toino.pt" ];
}
