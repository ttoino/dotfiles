{ modules, ... }:
{
  modules = with modules; [
    dns
    dynamic-dns
    media
    proxy
    ssh
  ];
}
