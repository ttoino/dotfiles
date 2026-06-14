{ ... }:
{
  home.stateVersion = "24.05";

  age.rekey.localStorageDir = ./secrets/home;

  wayland.windowManager.hyprland.extraLuaFiles."05-monitors".content = ./monitors.lua;
}
