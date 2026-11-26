{ modules, traits, ... }:
{
  username = "toino";

  traits = with traits; [
    base
    server
  ];

  modules = with modules; [ syncthing ];
}
