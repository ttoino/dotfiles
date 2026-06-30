{ pkgs, ... }:
let
  hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
  pidof = "${pkgs.procps}/bin/pidof";
  pkill = "${pkgs.procps}/bin/pkill";
  loginctl = "${pkgs.systemd}/bin/loginctl";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  dpmsOn = "${hyprctl} dispatch hl.dsp.dpms(\"on\")";
  dpmsOff = "${hyprctl} dispatch hl.dsp.dpms(\"off\")";
in
{
  home.packages = [ pkgs.hypridle ];

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "${pidof} hyprlock || ${hyprlock}";
        unlock_cmd = "${pkill} -USR1 hyprlock";
        before_sleep_cmd = "${loginctl} lock-session";
        after_sleep_cmd = dpmsOn;
      };

      listener = [
        # Turn brightness down after 2.5 minutes
        {
          timeout = 150;
          on-timeout = "${brightnessctl} -s set 0%";
          on-resume = "${brightnessctl} -r";
        }
        # Lock screen after 5 minutes
        {
          timeout = 300;
          on-timeout = "${loginctl} lock-session";
        }
        # Turn off screen after 10 minutes
        {
          timeout = 600;
          on-timeout = dpmsOff;
          on-resume = dpmsOn;
        }
        # Suspend after 30 minutes
        {
          timeout = 1800;
          on-timeout = "${systemctl} suspend";
        }
      ];
    };
  };
}
