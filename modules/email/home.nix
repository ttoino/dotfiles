{ config, ... }:
{
  accounts.email = {
    maildirBasePath = "Email";

    accounts = {
      personal_outlook = {
        address = "joaoapereira21@hotmail.com";
        realName = "João Pereira";
        aliases = [ "me@toino.pt" ];
        flavor = "outlook.office365.com";
        primary = true;

        offlineimap = {
          enable = true;

          extraConfig.remote = {
            oauth2_request_url = "https://login.microsoftonline.com/common/oauth2/v2.0/token";
            oauth2_client_id_eval = "get_secret('${config.age.secrets.email-outlook-client-id.path}')";
            oauth2_client_secret_eval = "get_secret('${config.age.secrets.email-outlook-client-secret.path}')";
            oauth2_refresh_token_eval = "get_secret('${config.age.secrets.email-personal-outlook-refresh-token.path}')";

            folderfilter = "lambda folder: not folder.startswith('Calendar') and not folder.startswith('Contacts')";
          };
        };
      };

      personal_gmail = {
        address = "jonny4547.3@gmail.com";
        realName = "João Pereira";
        flavor = "gmail.com";

        offlineimap = {
          enable = true;

          extraConfig.remote = {
            oauth2_client_id_eval = "get_secret('${config.age.secrets.email-google-client-id.path}')";
            oauth2_client_secret_eval = "get_secret('${config.age.secrets.email-google-client-secret.path}')";
            oauth2_refresh_token_eval = "get_secret('${config.age.secrets.email-personal-gmail-refresh-token.path}')";
          };
        };
      };

      university = {
        address = "up202007145@up.pt";
        realName = "João Pereira";
        flavor = "outlook.office365.com";

        offlineimap = {
          enable = true;

          extraConfig.remote = {
            oauth2_request_url = "https://login.microsoftonline.com/common/oauth2/v2.0/token";
            oauth2_client_id_eval = "get_secret('${config.age.secrets.email-outlook-client-id.path}')";
            oauth2_client_secret_eval = "get_secret('${config.age.secrets.email-outlook-client-secret.path}')";
            oauth2_refresh_token_eval = "get_secret('${config.age.secrets.email-university-refresh-token.path}')";

            folderfilter = "lambda folder: not folder.startswith('Calendar') and not folder.startswith('Contacts')";
          };
        };
      };
    };
  };

  programs.offlineimap = {
    enable = true;

    pythonFile = ''
      import subprocess

      def get_secret(path):
          return subprocess.check_output(f"cat {path}", shell=True).decode()
    '';
  };

  systemd.user = {
    services.offlineimap = {
      Unit = {
        Description = "offlineimap email synchronization";
        After = [ "network-online.target" ];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${config.programs.offlineimap.package}/bin/offlineimap";
      };
    };

    timers.offlineimap = {
      Unit = {
        Description = "offlineimap email synchronization";
      };

      Timer = {
        OnCalendar = "*:0/5";
        Unit = "offlineimap.service";
      };

      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
  };

  age.secrets = {
    email-google-client-id.rekeyFile = ./google_client_id.age;
    email-google-client-secret.rekeyFile = ./google_client_secret.age;

    email-outlook-client-id.rekeyFile = ./outlook_client_id.age;
    email-outlook-client-secret.rekeyFile = ./outlook_client_secret.age;

    email-personal-outlook-refresh-token.rekeyFile = ./personal_outlook_refresh_token.age;
    email-personal-gmail-refresh-token.rekeyFile = ./personal_gmail_refresh_token.age;
    email-university-refresh-token.rekeyFile = ./university_refresh_token.age;
  };
}
