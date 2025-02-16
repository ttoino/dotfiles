{ traits, ... }:
{
  system = "x86_64-linux";

  traits = with traits; [
    base
    cake
    dev
    gaming
    graphical
  ];

  modules = [ ];
}
