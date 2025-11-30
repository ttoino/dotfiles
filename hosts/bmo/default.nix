{ modules, traits, ... }:
{
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
