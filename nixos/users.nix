{
  services.getty.autologinUser = "toino";

  users.users.toino = {
    isNormalUser = true;
    description = "Toino";
    extraGroups = [
      "config"
      "docker"
      "networkManager"
      "wheel"
    ];
  };

  users.groups = {
    config = {};
  };
}
