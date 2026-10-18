{ config, pkgs, ... }:
{
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@${pkgs.sources.caddy-cloudflare.version}" ];
      hash = "sha256-xRJ5evsAJ2akg47j3Bt6YDXJOgX88B/rKNP50KSVyNY=";
    };
    globalConfig = "acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}";
    environmentFile = config.age.secrets.caddy-env.path;
    extraConfig = ''
      (private) {
        @not_private not remote_ip 10.0.0.0/24 192.168.0.0/16 127.0.0.1 ::1
        handle @not_private {
          respond "Forbidden" 403
        }
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  age.secrets.caddy-env.rekeyFile = ./caddy_env.age;
}
