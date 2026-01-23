{ modules, ... }:
{
  modules = with modules; [
    fonts
    gdm
    gui-apps
    kitty
    mopidy
    mpris
    proxy
    rescrobbled
    sound
  ];
}
