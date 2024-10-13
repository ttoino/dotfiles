{
  boot = {
    # TODO: Lanzaboote
    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        editor = false;
      };
    };

    plymouth = {
      enable = true;
    };
  };
}
