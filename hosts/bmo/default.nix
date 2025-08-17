{ modules, traits, ... }:
{
  system = "x86_64-linux";

  traits = with traits; [
    accounts
    base
    dev
    fionna
    gaming
    graphical
  ];

  modules = with modules; [
    battery
    fprint
    mullvad
  ];
}
