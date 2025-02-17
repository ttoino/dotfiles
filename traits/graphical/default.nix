{ modules, ... }:
{
  modules = with modules; [
    fonts
    gui-apps
    kitty
    mopidy
    mpris
    proxy
    sound
  ];
}
