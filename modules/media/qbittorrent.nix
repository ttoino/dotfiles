{ pkgs, ... }:
{
  services.qbittorrent = {
    enable = true;
    group = "media";
    webuiPort = 6969;

    serverConfig = {
      Preferences = {
        Downloads = {
          SavePath = "/data/downloads/torrents";
        };
        Bittorrent = {
          QueueingMaxActiveDownloads = 10;
          QueueingMaxActiveTorrents = 10;
          QueueingMaxActiveUploads = 1;
          MaxConnecs = -1;
        };
        WebUI = {
          Username = "toino";
          Password_PBKDF2 = "@ByteArray(n98T2LGMsFzeY7IxB2t/aw==:JQch42Q3s8hSg82PegFBLLOuSCK7Qh5ooBka5HTSF57co6N6IG4AxodeRdT4BGjNoUpkfdkVCSjAZ1duZsLe0A==)";
          AlternativeUIEnabled = true;
          RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";
        };
      };
    };
  };

  services.caddy.virtualHosts."torrents.toino.pt".extraConfig = "reverse_proxy * localhost:6969";

  networking.hosts."127.0.0.1" = [ "torrents.toino.pt" ];
}
