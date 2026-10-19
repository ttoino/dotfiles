{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.services.qbittorrent;
in
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
          AlternativeUIEnabled = true;
          RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";
        };
      };
    };
  };

  systemd.services.qbittorrent.serviceConfig.ExecStartPre = lib.mkAfter [
    (pkgs.writeShellScript "qbittorrent-set-webui-credentials" ''
      username=$(cat ${config.age.secrets.media-username.path})
      hash=$(cat ${config.age.secrets.qbittorrent-webui-password-hash.path})
      conf=/var/lib/qBittorrent/qBittorrent/config/qBittorrent.conf
      ${pkgs.gnused}/bin/sed -i '/^WebUI\\Username=/d' "$conf"
      ${pkgs.gnused}/bin/sed -i '/^WebUI\\Password_PBKDF2=/d' "$conf"
      printf 'WebUI\\Username=%s\n' "$username" >> "$conf"
      printf 'WebUI\\Password_PBKDF2=%s\n' "$hash" >> "$conf"
    '')
  ];

  services.caddy.virtualHosts."torrents.toino.pt".extraConfig = ''
    import private
    reverse_proxy * localhost:6969
  '';

  networking.hosts."127.0.0.1" = [ "torrents.toino.pt" ];

  age.secrets.qbittorrent-webui-password-hash = {
    rekeyFile = ./qbittorrent_webui_password_hash.age;
    owner = cfg.user;
    group = cfg.group;
    generator = {
      script = "pbkdf2";
      dependencies = [ config.age.secrets.media-password ];
    };
  };
}
