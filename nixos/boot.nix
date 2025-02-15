{ inputs, pkgs, ... }: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        editor = false;
        edk2-uefi-shell.enable = true;
        windows.windows = {
          title = "Windows";
          efiDeviceHandle = "FS0";
        };
      };
    };

    plymouth = { enable = true; };

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
