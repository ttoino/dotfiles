{ ... }:
{
  services.radarr = {
    enable = true;
    group = "media";
  };

  services.caddy.virtualHosts."movies.toino.pt".extraConfig = ''
    import private
    reverse_proxy * localhost:7878
  '';

  networking.hosts."127.0.0.1" = [ "movies.toino.pt" ];
}
