{ modules, ... }:
{
  modules = with modules; [
    ags
    autologin
    hypridle
    hyprland
    hyprlock
    hyprpaper
  ];

  home = [ ];

  nixos = [ ];
}
