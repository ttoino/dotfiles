{ config, ... }:
{
  accounts.calendar = {
    basePath = "Calendar";

    accounts.personal_gmail = {
      remote.type = "google_calendar";

      vdirsyncer = {
        enable = true;
        collections = [ "from a" ];

        tokenFile = "~/.config/vdirsyncer/google_calendar_token";
        clientIdCommand = [
          "cat"
          config.age.secrets.vdirsyncer-google-client-id.path
        ];
        clientSecretCommand = [
          "cat"
          config.age.secrets.vdirsyncer-google-client-secret.path
        ];
      };

      khal = {
        enable = true;
        type = "discover";
      };
    };
  };

  programs.khal.enable = true;
  programs.vdirsyncer.enable = true;
  services.vdirsyncer.enable = true;

  age.secrets = {
    vdirsyncer-google-client-id.rekeyFile = ./vdirsyncer_google_client_id.age;
    vdirsyncer-google-client-secret.rekeyFile = ./vdirsyncer_google_client_secret.age;
  };
}
