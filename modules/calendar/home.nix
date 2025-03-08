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
          "sh"
          "-c"
          "cat ${config.age.secrets.calendar-google-client-id.path}"
        ];
        clientSecretCommand = [
          "sh"
          "-c"
          "cat ${config.age.secrets.calendar-google-client-secret.path}"
        ];
      };

      khal = {
        enable = true;
        type = "discover";
      };
    };
  };

  programs.khal = {
    enable = true;

    locale = {
      dateformat = "%Y-%m-%d";
      longdateformat = "%Y-%m-%d";
      timeformat = "%H:%M:%S";
      datetimeformat = "%Y-%m-%dT%H:%M:%S";
      longdatetimeformat = "%Y-%m-%dT%H:%M:%S";
    };
  };

  programs.vdirsyncer.enable = true;
  services.vdirsyncer.enable = true;

  age.secrets = {
    calendar-google-client-id.rekeyFile = ./google_client_id.age;
    calendar-google-client-secret.rekeyFile = ./google_client_secret.age;
  };
}
