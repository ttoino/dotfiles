{ modules, ... }:
{
  modules = with modules; [
    fonts
    kitty
    mopidy
  ];
  home = [ ];
  nixos = [ ];
}
