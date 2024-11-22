{ pkgs, ... }: {
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  networking = {
    networkmanager.enable = true;

    hosts = {
      "127.0.0.1" = builtins.map (x: x + ".local") ([
        # Streaming
        "jellyfin"
        "watch"
        "radarr"
        "movies"
        "sonarr"
        "series"
        "lidarr"
        "music"
        "readarr"
        "books"
        "bazarr"
        "subtitles"
        "prowlarr"
        "trackers"
        "qbittorrent"
        "torrents"
      ]);
    };
  };
}
