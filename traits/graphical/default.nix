{ modules, ... }:
{
  modules = with modules; [
    cursor
    fonts
    gdm
    gui-apps
    kitty
    mopidy
    mpris
    proxy
    rescrobbled
    sound
    theming
  ];
}
