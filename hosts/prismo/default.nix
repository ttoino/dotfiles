{ modules, traits, ... }:
{
  system = "x86_64-linux";

  traits = with traits; [
    base
    media
  ];

  modules = with modules; [ ssh ];
}
