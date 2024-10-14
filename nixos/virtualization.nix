{
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      storageDriver = "btrfs";

      autoPrune = {
        enable = true;
        dates = "weekly";
      };

      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    virtualbox.host.enable = true;
  };
}
