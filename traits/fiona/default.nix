{ modules, ... }:
{
  modules = with modules; [
    autologin
    cake
    hypridle
    hyprland
    hyprlock
    hyprpaper
  ];
}
