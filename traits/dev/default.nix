{ modules, ... }:
{
  modules = with modules; [
    docker
    git
  ];
}
