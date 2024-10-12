{
  services.hyprpaper = {
    enable = true;

    settings = {
      preload = [ (toString ./wallpapers/hollow-knight.png) ];
      wallpaper = [ ",${toString ./wallpapers/hollow-knight.png}" ];
    };
  };
}
