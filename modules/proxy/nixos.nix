{ config, pkgs, ... }:
{
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
      hash = "sha256-hEIqK6F+9OCcd4JueVSidfUgQsVPWo0/imciD1UnqRo=";
    };
    globalConfig = "acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}";
    environmentFile = config.age.secrets.caddy-env.path;
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  age.secrets.caddy-env.rekeyFile = ./caddy_env.age;
}
