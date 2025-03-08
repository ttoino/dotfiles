{ pkgs, ... }:
{
  home.packages = [ pkgs.hyprpaper ];

  services.hyprpaper = {
    enable = true;

    settings = {
      preload = [ "${./wallpapers/outer-wilds-color.png}" ];
      wallpaper = [ ",${./wallpapers/outer-wilds-color.png}" ];
    };
  };
}
