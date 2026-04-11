{ config, ... }:
{
  services.rescrobbled = {
    enable = true;

    settings = {
      lastfm-key-file = config.age.secrets.rescrobbled-key.path;
      lastfm-secret-file = config.age.secrets.rescrobbled-secret.path;
    };
  };

  systemd.user.services.rescrobbled.Unit.After = [ "agenix.service" ];

  age.secrets = {
    rescrobbled-key.rekeyFile = ./key.age;
    rescrobbled-secret.rekeyFile = ./secret.age;
  };
}
