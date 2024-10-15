{
  services.getty.autologinUser = "toino";

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
    config = {};
  };
}
