{ config, ... }:
{
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.age.secrets.cloudflare-api-token.path;
  };

  age.secrets.cloudflare-api-token.rekeyFile = ./cloudflare_api_token.age;
}
