{ username, ... }:
{
  users.groups = {
    config = { };
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "Toino";
    extraGroups = [
      "config"
      "networkmanager"
      "wheel"
    ];
  };
}
