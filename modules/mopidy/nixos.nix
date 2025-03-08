{ ... }:
{
  age.secrets = {
    mopidy-google-client-id = {
      rekeyFile = ./mopidy_google_client_id.age;
      owner = "toino";
    };
    mopidy-google-client-secret = {
      rekeyFile = ./mopidy_google_client_secret.age;
      owner = "toino";
    };
  };

  networking.hosts."127.0.0.1" = [ "listen.toino.pt" ];

  # https://github.com/jaedb/Iris/wiki/Advanced#encryption-httpswss
  services.caddy.virtualHosts."listen.toino.pt".extraConfig = ''
    reverse_proxy * localhost:6680
    redir / /iris
  '';
}
