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

  services.caddy.virtualHosts."soulseek.toino.pt".extraConfig = "reverse_proxy * localhost:5030";

  networking.hosts."127.0.0.1" = [ "soulseek.toino.pt" ];

  age.secrets = {
    slskd-env = {
      rekeyFile = ./slskd_env.age;
      owner = cfg.user;
      group = cfg.group;
    };
  };
}
