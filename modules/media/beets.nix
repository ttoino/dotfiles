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
        ExecStart = "${pkgs.beets}/bin/beet import /data/media/music/untagged";
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
          from_scratch = false;
          quiet = true;
          log = "/var/lib/beets/log.log";
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