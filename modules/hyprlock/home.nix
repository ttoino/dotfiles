{
  programs.hyprlock = {
    enable = true;

    settings = {
      background = [
        {
          path = "screenshot";
          blur_size = 8;
          blur_passes = 3;
        }
      ];
    };
  };

  wayland.windowManager.hyprland.settings.exec-once = [ "hyprlock" ];
}
