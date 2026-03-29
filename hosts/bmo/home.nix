{ ... }:
{
  home.stateVersion = "24.05";

  age.rekey.localStorageDir = ./secrets/home;

  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-2, preferred, auto, 1.333"
    "desc:LG Electronics LG TV, preferred, auto-left, 1"
    "desc:Samsung Electric Company LC32G5xT H4ZR703681, preferred, auto-left, 1"
    ", preferred, auto, 1"
  ];
}
