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

      # More trouble than it's worth
      # rootless = {
      #   enable = true;
      #   setSocketVariable = true;
      # };
    };

    virtualbox.host.enable = true;
  };
}
