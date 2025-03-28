{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    gytmdl
  ];

  services.mopidy = {
    enable = true;

    extensionPackages = with pkgs; [
      mopidy-local
      mopidy-mpris
      mopidy-iris
    ];

    settings = {
      file.enabled = false;

      http = {
        allowed_origins = ["localhost:5173"];
        default_app = "iris";
      };

      local.media_dir = "~/Music";
    };
  };
}
