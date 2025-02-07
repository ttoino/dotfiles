{ config, lib, pkgs, ... }:
{
  services.mopidy = {
    enable = true;

    extensionPackages = with pkgs; [
      mopidy-mpris
      mopidy-iris
      mopidy-ytmusic
    ];

    settings = {
      ytmusic = {
        auth_json = "~/.config/mopidy/auth.json";
        oauth_json = "~/.config/mopidy/oauth.json";
        oauth_client_id = "@mopidy-google-client-id@";
        oauth_client_secret = "@mopidy-google-client-secret@";

        playlist_item_limit = 10000;
      };
    };
  };

  home.activation.mopidy-ytmusic-credentials = lib.hm.dag.entryAfter ["writeBoundary"] ''
    id=$(cat "${config.age.secrets.mopidy-google-client-id.path}")
    secret=$(cat "${config.age.secrets.mopidy-google-client-secret.path}")
    config_file="''${XDG_CONFIG_HOME:-${config.xdg.configHome}}/mopidy/mopidy.conf"
    ${pkgs.gnused}/bin/sed -i "s/@mopidy-google-client-id@/$id/" "$config_file"
    ${pkgs.gnused}/bin/sed -i "s/@mopidy-google-client-secret@/$secret/" "$config_file"
  '';
}
