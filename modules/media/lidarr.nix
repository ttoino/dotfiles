{ config, ... }:
{
  services.lidarr = {
    enable = true;
    group = "media";
    environmentFiles = [ config.age.secrets.lidarr-env.path ];
  };

  services.caddy.virtualHosts."music.toino.pt".extraConfig = "reverse_proxy * localhost:8686";

  networking.hosts."127.0.0.1" = [ "music.toino.pt" ];

  age.secrets.lidarr-env = {
    generator = {
      dependencies = [ config.age.secrets.lidarr-api-key ];
      script = { lib, decrypt, deps, ... }: ''
        api_key=$(${decrypt} ${lib.escapeShellArg (builtins.elemAt deps 0).file})
        echo "LIDARR__AUTH__APIKEY=$api_key"
      '';
    };
    rekeyFile = ./lidarr_env.age;
    owner = "lidarr";
    group = "media";
  };
}
