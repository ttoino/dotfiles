{ username, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    storageDriver = "btrfs";

    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  users.users.${username}.extraGroups = [ "docker" ];
}
