{
  config,
  ...
}:
let
  cfg = config.services.slskd;
in
{
  services.slskd = {
    enable = true;
    group = "media";
    environmentFile = config.age.secrets.slskd-env.path;
    domain = null;

    settings = {
      shares.directories = [ ];
      directories = {
        incomplete = "/data/downloads/soulseek/incomplete";
        downloads = "/data/downloads/soulseek/complete";
      };
      transfers.download.destination.permissions.mode = "775";
    };
  };

  systemd.services.slskd.serviceConfig.UMask = "0002";

  services.caddy.virtualHosts."soulseek.toino.pt".extraConfig = ''
    import private
    reverse_proxy * localhost:5030
  '';

  networking.hosts."127.0.0.1" = [ "soulseek.toino.pt" ];

  age.secrets = {
    slskd-api-key.rekeyFile = ./slskd_api_key.age;
    slskd-slsk-username.rekeyFile = ./slskd_slsk_username.age;
    slskd-slsk-password.rekeyFile = ./slskd_slsk_password.age;

    slskd-env = {
      rekeyFile = ./slskd_env.age;
      owner = cfg.user;
      group = cfg.group;
      generator = {
        script = "env";
        dependencies = with config.age.secrets; {
          inherit slskd-api-key slskd-slsk-username slskd-slsk-password;
          slskd-username = media-username;
          slskd-password = media-password;
        };
      };
    };
  };
}
