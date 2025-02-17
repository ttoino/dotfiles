{ config, ... }:
{
  accounts.contact = {
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
        clientIdCommand = [
          "cat"
          config.age.secrets.contacts-google-client-id.path
        ];
        clientSecretCommand = [
          "cat"
          config.age.secrets.contacts-google-client-secret.path
        ];
      };

      khard = {
        enable = true;
        defaultCollection = "default";
      };
    };
  };

  programs.khard.enable = true;
  programs.vdirsyncer.enable = true;
  services.vdirsyncer.enable = true;

  age.secrets = {
    contacts-google-client-id.rekeyFile = ./google_client_id.age;
    contacts-google-client-secret.rekeyFile = ./google_client_secret.age;
  };
}
