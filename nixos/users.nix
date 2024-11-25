{ config, lib, ... }:
{
  services.getty = {
    autologinUser = "toino";
    autologinOnce = true;
  };

  users.groups = {
    config = { };
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
}
