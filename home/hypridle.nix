{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        unlock_cmd = "kill --signal SIGUSR1 $(pidof hyprlock)";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      
      listener = [
        # Turn brightness down after 2.5 minutes
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 0%";
          on-resume = "brightnessctl -r";
        }
        # Lock screen after 5 minutes
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        # Turn off screen after 10 minutes
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # Suspend after 30 minutes
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
