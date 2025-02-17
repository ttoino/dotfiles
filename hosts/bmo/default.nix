{ modules, traits, ... }:
{
  system = "x86_64-linux";

  traits = with traits; [
    accounts
    base
    cake
    dev
    gaming
    graphical
  ];

  modules = with modules; [
    battery
    fprint
  ];
}
