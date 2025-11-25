{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  secrets-script = lib.getExe (
    pkgs.writeShellApplication {
      name = "agenix-home-manager-mount-secrets";
      runtimeInputs = with pkgs; [ coreutils ];
      text = ''
        config_file="''${XDG_CONFIG_HOME:-${config.xdg.configHome}}/mopidy/mopidy.conf"
        backup_file="$config_file.${osConfig.home-manager.backupFileExtension}"

        rm -f "$backup_file"

        scrobbler_username=$(cat "${config.age.secrets.mopidy-scrobbler-username.path}")
        scrobbler_password=$(cat "${config.age.secrets.mopidy-scrobbler-password.path}")

        ${pkgs.gnused}/bin/sed -i "s/@scrobbler-username@/$scrobbler_username/" "$config_file"
        ${pkgs.gnused}/bin/sed -i "s/@scrobbler-password@/$scrobbler_password/" "$config_file"
      '';
    }
  );
in
{
  services.mopidy = {
    enable = true;

    extensionPackages = with pkgs; [
      mopidy-dynamic
      mopidy-local
      mopidy-marceline
      mopidy-mpris
      mopidy-iris
      mopidy-scrobbler
    ];

    settings = {
      core.restore_state = true;

      file.enabled = false;

      http = {
        allowed_origins = [ "localhost:5173" ];
        default_app = "marceline";
      };

      local.media_dir = "~/Music";

      logging.verbosity = 3;

      scrobbler = {
        username = "@scrobbler-username@";
        password = "@scrobbler-password@";
      };
    };
  };

  age.secrets = {
    mopidy-scrobbler-username.rekeyFile = ./scrobbler_username.age;
    mopidy-scrobbler-password.rekeyFile = ./scrobbler_password.age;
  };

  systemd.user.services.mopidy-secrets = {
    Unit = {
      Description = "Setup mopidy secrets";
      Requires = [ "agenix.service" ];
      After = [ "agenix.service" ];
      Before = [ "mopidy.service" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = secrets-script;
    };
    Install.WantedBy = [ "default.target" ];
  };
}
