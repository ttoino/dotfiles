{ config, ... }:
{
  services.rescrobbled = {
    enable = true;

    settings = {
      lastfm-key-file = config.age.secrets.rescrobbled-lastfm-key.path;
      lastfm-secret-file = config.age.secrets.rescrobbled-lastfm-secret.path;

      listenbrainz-token-file = config.age.secrets.rescrobbled-listenbrainz-token.path;
    };
  };

  systemd.user.services.rescrobbled.Unit.After = [ "agenix.service" ];

  age.secrets = {
    rescrobbled-lastfm-key.rekeyFile = ./lastfm-key.age;
    rescrobbled-lastfm-secret.rekeyFile = ./lastfm-secret.age;

    rescrobbled-listenbrainz-token.rekeyFile = ./listenbrainz-token.age;
  };
}
