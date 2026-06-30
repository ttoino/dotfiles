{ pkgs, ... }:
{
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

  # Trigger mopidy-scan after syncthing finishes syncing
  systemd.user.services.mopidy-scan-trigger = {
    Unit = {
      Description = "Trigger mopidy local scan after syncthing sync";
      After = [ "syncthing.service" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writers.writePython3 "mopidy-scan-trigger" { } (
        builtins.readFile ./mopidy_scan_trigger.py
      )}";
    };
  };

  systemd.user.timers.mopidy-scan-trigger = {
    Timer = {
      OnBootSec = "2min";
      OnUnitActiveSec = "1min";
      Unit = "mopidy-scan-trigger.service";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
