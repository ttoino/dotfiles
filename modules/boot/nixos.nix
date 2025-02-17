{ ... }:
{
  # TODO: Almost works
  #   systemd.services = {
  #     plymouth-quit = {
  #       serviceConfig.ExecStart = [
  #         ""
  #         "-${pkgs.plymouth}/bin/plymouth quit --retain-splash"
  #       ];
  #       restartIfChanged = false;
  #     };
  #     hyprpaper-loaded = {
  #       description = "Waits for hyprpaper to finish loading before quitting plymouth";
  #       after = [ "plymouth-quit.service" ];
  #       wantedBy = [ "multi-user.service" ];
  #       restartIfChanged = false;
  #       script = ''
  #         get_env() {
  #           grep -Poa '(?<='"$1"'=)[^\0]+' "/proc/$(${pkgs.procps}/bin/pgrep -x hyprpaper)/environ"
  #         }

  #         while ! XDG_RUNTIME_DIR="$(get_env XDG_RUNTIME_DIR)" HYPRLAND_INSTANCE_SIGNATURE="$(get_env HYPRLAND_INSTANCE_SIGNATURE)" ${pkgs.hyprland}/bin/hyprctl hyprpaper listactive; do
  #           sleep 1
  #         done

  #         while ! ${pkgs.procps}/bin/pgrep -x hyprlock; do
  #           sleep 1
  #         done

  #         loginctl unlock-sessions
  #         sleep 1
  #         loginctl lock-sessions
  #         ${pkgs.plymouth}/bin/plymouth quit
  #       '';
  #       serviceConfig = {
  #         Type = "oneshot";
  #       };
  #     };
  #   };

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        editor = false;
        edk2-uefi-shell.enable = true;
      };
    };

    plymouth.enable = true;

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
