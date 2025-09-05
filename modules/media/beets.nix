{ lib, pkgs, ... }:
{
  users.users.beets = {
    isSystemUser = true;
    group = "media";
    home = "/var/lib/beets";
  };

  systemd = {
    services.beets = {
      description = "Beets Music Library Manager";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        User = "beets";
        Group = "media";
        UMask = "0002";
        ExecStart = "${pkgs.beets}/bin/beet import --quiet /data/media/music/untagged";
        Restart = "on-failure";
      };
    };

    timers.beets = {
      description = "Beets Music Library Manager";
      wantedBy = [ "timers.target" ];

      timerConfig = {
        OnCalendar = "00:00:00";
        Unit = "beets.service";
      };
    };
  };

  system.activationScripts.beets =
    let
      cfg = lib.generators.toYAML { } {
        directory = "/data/media/music/tagged";

        plugins = [
          "embedart"
          "fetchart"
          "lastgenre"
        ];

        import = {
          write = true;
          copy = true;
          resume = true;
          incremental = true;
          incremental_skip_later = true;
          from_scratch = false;
          log = "/var/lib/beets/log.log";
        };

        match = {
          max_rec = {
            album = "medium";
            artist = "medium";
            missing_tracks = "medium";
            unmatched_tracks = "medium";
          };
          preferred = {
            countries = [
              "XW"
              "US"
              "GB|UK"
              "KR"
            ];
            media = [ "Digital Media|File" ];
            original_year = true;
          };
          strong_rec_thresh = 0.6;
        };

        embedart = {
          remove_art_file = true;
        };

        fetchart = {
          enforce_ratio = true;
        };

        lastgenre = {
          force = true;
        };
      };
    in
    ''
      mkdir -p /var/lib/beets/.config/beets
      cat >/var/lib/beets/.config/beets/config.yaml <<-'EOF'
      ${cfg}
      EOF

      chown -R beets:media /var/lib/beets
      chmod -R 0755 /var/lib/beets
    '';
}
