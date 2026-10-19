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
    printing
    proxy
    rescrobbled
    sound
    theming
  ];
}
