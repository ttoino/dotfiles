{ modules, traits, ... }:
{
  traits = with traits; [
    base
    server
  ];

  modules = with modules; [ syncthing ];
}
