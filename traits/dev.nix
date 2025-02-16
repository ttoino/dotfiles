{ modules, ... }:
{
  modules = with modules; [
    docker
    git
  ];
  home = [ ];
  nixos = [ ];
}
