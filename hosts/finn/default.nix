{ modules, traits, ... }:
{
  boot.initrd.systemd.enable = true;

  traits = with traits; [
    accounts
    base
    dev
    fionna
    gaming
    graphical
  ];

  modules = with modules; [
    automatic-timezone
    battery
    fprint
    mullvad
    syncthing
  ];
}
