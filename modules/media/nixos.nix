{ ... }:
{
  imports = [
    ./bazarr.nix
    ./beets.nix
    ./qbittorrent.nix
    ./jellyfin.nix
    ./lidarr.nix
    ./prowlarr.nix
    ./radarr.nix
    ./readarr.nix
    ./sonarr.nix
    ./soulseek.nix
  ];

  users = {
    users.media = {
      isSystemUser = true;
      group = "media";
    };
    groups.media = { };
  };

  systemd.tmpfiles.settings = {
    "10-media" = {
      "/data/downloads".d = {
        user = "media";
        group = "media";
        mode = "0775";
      };

      "/data/media".d = {
        user = "media";
        group = "media";
        mode = "0775";
      };
    };

    "20-media" = {
      "/data/downloads/torrents".d = {
        user = "qbittorrent";
        group = "media";
        mode = "0775";
      };
      "/data/downloads/soulseek".d = {
        user = "slskd";
        group = "media";
        mode = "0775";
      };

      "/data/media/books".d = {
        user = "readarr";
        group = "media";
        mode = "0775";
      };
      "/data/media/movies".d = {
        user = "radarr";
        group = "media";
        mode = "0775";
      };
      "/data/media/music".d = {
        user = "media";
        group = "media";
        mode = "0775";
      };
      "/data/media/shows".d = {
        user = "sonarr";
        group = "media";
        mode = "0775";
      };
    };

    "30-media" = {
      "/data/downloads/soulseek/incomplete".d = {
        user = "slskd";
        group = "media";
        mode = "0775";
      };
      "/data/downloads/soulseek/complete".d = {
        user = "slskd";
        group = "media";
        mode = "0775";
      };

      "/data/media/music/untagged".d = {
        user = "lidarr";
        group = "media";
        mode = "0775";
      };
      "/data/media/music/tagged".d = {
        user = "beets";
        group = "media";
        mode = "0775";
      };
    };
  };
}
