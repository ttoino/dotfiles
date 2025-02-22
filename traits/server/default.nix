{ modules, ... }:
{
  modules = with modules; [
    dns
    media
    proxy
    ssh
  ];
}
