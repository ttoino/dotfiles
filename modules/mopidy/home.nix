{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
{
  services.mopidy = {
    enable = true;

    extensionPackages = with pkgs; [
      mopidy-local
      mopidy-marceline
      mopidy-mpris
      mopidy-iris
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
    };
  };
}
