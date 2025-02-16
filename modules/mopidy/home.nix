{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
{
  services.mopidy = {
    enable = true;

    extensionPackages = with pkgs; [
      mopidy-mpris
      mopidy-iris
      (mopidy-ytmusic.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
          owner = "LittleFox94";
          repo = "mopidy-ytmusic";
          rev = "random-fixes";
          sha256 = "sha256-U4HNY5CNXs0yQ2fklVisOCIQAbF1fabD/yptEU0Joz4=";
        };

        postPatch = "";

        nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.python3.pkgs.poetry-core ];

        propagatedBuildInputs = old.propagatedBuildInputs ++ [
          pkgs.python3.pkgs.pytubefix
        ];
      }))
    ];

    settings = {
      ytmusic = {
        auth_json = "~/.config/mopidy/auth.json";
        oauth_json = "~/.config/mopidy/oauth.json";
        oauth_client_id = "@mopidy-google-client-id@";
        oauth_client_secret = "@mopidy-google-client-secret@";

        playlist_item_limit = 10000;
      };
    };
  };

  age.secrets = {
    mopidy-google-client-id.rekeyFile = ./mopidy_google_client_id.age;
    mopidy-google-client-secret.rekeyFile = ./mopidy_google_client_secret.age;
  };

  home.activation.mopidy-ytmusic-credentials =
    lib.hm.dag.entryAfter [ "writeBoundary" ]
      ''
        id=$(cat "${config.age.secrets.mopidy-google-client-id.path}")
        secret=$(cat "${config.age.secrets.mopidy-google-client-secret.path}")
        config_file="''${XDG_CONFIG_HOME:-${config.xdg.configHome}}/mopidy/mopidy.conf"
        backup_file="$config_file.${osConfig.home-manager.backupFileExtension}"
        run rm -f "$backup_file"
        run ${pkgs.gnused}/bin/sed -i "s/@mopidy-google-client-id@/$id/" "$config_file"
        run ${pkgs.gnused}/bin/sed -i "s/@mopidy-google-client-secret@/$secret/" "$config_file"
      '';
}
