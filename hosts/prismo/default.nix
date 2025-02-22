{ traits, ... }:
{
  system = "x86_64-linux";

  traits = with traits; [
    base
    server
  ];

  modules = [ ];
}
