{ pkgs, ... }:
{
  home.stateVersion = "24.05";

  age.rekey.localStorageDir = ./secrets/home;

  wayland.windowManager.hyprland.extraLuaFiles."05-monitors".content = ./monitors.lua;

  # Syncthing (music sync from prismo)
  services.syncthing = {
    enable = true;
    settings = {
      devices.prismo = {
        id = "4YP6MW3-6J4IZFU-FHBJSN6-T56L47M-AGWKR42-6EEZYSB-CBCVBRH-W2QSSQV";
        addresses = [ "tcp://10.0.0.1:22000" ];
      };
      folders.music = {
        path = "/home/toino/Music";
        devices = [ "prismo" ];
        type = "receiveonly";
      };
    };
  };
}

