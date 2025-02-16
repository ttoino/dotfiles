{ pkgs, ... }: {
  home.packages = [ pkgs.hyprpaper ];

  services.hyprpaper = {
    enable = true;

    settings = {
      preload = [ (toString ./wallpapers/outer-wilds-color.png) ];
      wallpaper = [ ",${toString ./wallpapers/outer-wilds-color.png}" ];
    };
  };
}
