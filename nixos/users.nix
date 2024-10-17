{ config, lib, ... }:
let
  serviceCmd = builtins.elemAt config.systemd.services."getty@".serviceConfig.ExecStart 1;
in
{
  systemd.services."getty@tty1" = {
    overrideStrategy = "asDropin";
    restartIfChanged = false;
    serviceConfig.ExecStart = [
      ""
      "${serviceCmd} --autologin toino"
    ];
  };

  users.users.toino = {
    isNormalUser = true;
    description = "Toino";
    extraGroups = [
      "config"
      "docker"
      "networkmanager"
      "wheel"
    ];
  };

  users.groups = {
    config = { };
  };
}
