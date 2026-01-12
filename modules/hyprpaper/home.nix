{ pkgs, ... }:
{
  home.packages = [ pkgs.hyprpaper ];

  services.hyprpaper = {
    enable = true;

    settings = {
      wallpaper = {
        monitor = "";
        path = "${./wallpapers/outer-wilds-color.png}";
      };

      splash = false;
    };
  };
}
