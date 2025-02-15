{ config, ... }: {
  accounts = {
    calendar = {
      basePath = "Calendar";

      accounts.personal_gmail = {
        remote.type = "google_calendar";

        vdirsyncer = {
          enable = true;
          collections = [ "from a" ];

          tokenFile = "~/.config/vdirsyncer/google_calendar_token";
          clientIdCommand =
            [ "cat" config.age.secrets.vdirsyncer-google-client-id.path ];
          clientSecretCommand =
            [ "cat" config.age.secrets.vdirsyncer-google-client-secret.path ];
        };

        khal = {
          enable = true;
          type = "discover";
        };
      };
    };

    contact = {
      basePath = "Contacts";

      accounts.personal_gmail = {
        remote.type = "google_contacts";

        local = {
          type = "filesystem";
          fileExt = ".vcf";
        };

        vdirsyncer = {
          enable = true;
          collections = [ "from a" ];

          tokenFile = "~/.config/vdirsyncer/google_contacts_token";
          clientIdCommand =
            [ "cat" config.age.secrets.vdirsyncer-google-client-id.path ];
          clientSecretCommand =
            [ "cat" config.age.secrets.vdirsyncer-google-client-secret.path ];
        };

        khard = {
          enable = true;
          defaultCollection = "default";
        };
      };
    };

    # TODO
    # email.accounts = { };
  };

  programs.vdirsyncer.enable = true;
  services.vdirsyncer.enable = true;
}
