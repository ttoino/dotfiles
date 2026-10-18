{ ... }:
{
  services.bazarr = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts."captions.toino.pt".extraConfig = ''
    import private
    reverse_proxy * localhost:6767
  '';

  networking.hosts."127.0.0.1" = [ "captions.toino.pt" ];
}
