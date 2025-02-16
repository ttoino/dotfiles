{ ... }:
{
  users.groups = {
    config = { };
  };

  users.users.toino = {
    isNormalUser = true;
    description = "Toino";
    extraGroups = [
      "config"
      "networkmanager"
      "wheel"
    ];
  };
}
