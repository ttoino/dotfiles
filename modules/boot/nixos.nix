{ ... }:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        efiSupport = true;
        configurationLimit = 5;
        device = "nodev";
        extraEntries = ''
          menuentry "UEFI Firmware Settings" --class efi {
            fwsetup
          }
        '';
      };
    };

    plymouth.enable = true;

    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
}
