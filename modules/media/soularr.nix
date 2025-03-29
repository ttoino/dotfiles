{ config, lib, pkgs, ... }:
{
  users.users.soularr = {
    isSystemUser = true;
    group = "media";
    home = "/var/lib/soularr";
  };

  systemd = {
    services.soularr = {
      description = "Soularr";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        User = "soularr";
        Group = "media";
        UMask = "0002";
        ExecStart = "${pkgs.soularr}/bin/soularr --config-dir /var/lib/soularr/.config/soularr";
        Restart = "on-failure";
      };
    };

    timers.soularr = {
      description = "Soularr";
      wantedBy = [ "timers.target" ];

      timerConfig = {
        OnCalendar = "*:0/5";
        Unit = "soularr.service";
      };
    };
  };

  system.activationScripts.soularr =
    let
      cfg = lib.generators.toINI { } {
        Lidarr = {
          api_key = "@lidarr_api_key@";
          host_url = "http://localhost:8686";
          download_dir = "/data/downloads/soulseek/complete";
        };

        Slskd = {
          api_key = "@slskd_api_key@";
          host_url = "http://localhost:5030";
          download_dir = "/data/downloads/soulseek/complete";
        };

        "Release Settings" = {
          use_most_common_tracknum = "False";
          allow_multi_disc = "False";
          accepted_countries = "[Worldwide],Europe,United States,United Kingdom,Canada";
          accepted_formats = "Digital Media";
        };

        "Search Settings" = {
          minimum_peer_upload_speed = "100";
          search_for_tracks = "False";
          album_prepend_artist = "True";
          number_of_albums_to_grab = "1";
        };
      };
    in
    ''
      mkdir -p /var/lib/soularr/.config/soularr

      cat >/var/lib/soularr/.config/soularr/config.ini <<-'EOF'
      ${cfg}
      EOF

      chown -R soularr:media /var/lib/soularr
      chmod -R 0775 /var/lib/soularr

      lidarr_api_key=$(cat "${config.age.secrets.lidarr-api-key.path}")
      slskd_api_key=$(cat "${config.age.secrets.slskd-api-key.path}")
      ${pkgs.gnused}/bin/sed -i "s/@lidarr_api_key@/$lidarr_api_key/g" /var/lib/soularr/.config/soularr/config.ini
      ${pkgs.gnused}/bin/sed -i "s/@slskd_api_key@/$slskd_api_key/g" /var/lib/soularr/.config/soularr/config.ini
    '';
}
