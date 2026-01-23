{ config, lib, ... }:
{
  services.rescrobbled.enable = true;

  systemd.user.services.rescrobbled = {
    Service.ExecStart = lib.mkForce "/bin/sh -c 'LASTFM_KEY=$(cat ${config.age.secrets.rescrobbled-key.path}) LASTFM_SECRET=$(cat ${config.age.secrets.rescrobbled-secret.path}) exec ${lib.getExe config.services.rescrobbled.package}'";
    Unit.After = [ "agenix.service" ];
  };

  age.secrets = {
    rescrobbled-key.rekeyFile = ./key.age;
    rescrobbled-secret.rekeyFile = ./secret.age;
  };
}
