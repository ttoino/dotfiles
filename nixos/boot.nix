{ inputs, pkgs, ... }: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  environment.systemPackages = with pkgs; [
    sbctl
  ];

  boot = {
    # TODO: Lanzaboote
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 0;

      systemd-boot = {
        # enable = true;
        editor = false;
      };
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    plymouth = {
      enable = true;
    };

    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
}
