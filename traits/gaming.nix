{ modules, ... }:
{
  modules = with modules; [ steam ];
  home = [ ];
  nixos = [ ];
}
