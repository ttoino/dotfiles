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

  wayland.windowManager.hyprland.extraLuaFiles."07-hyprlock-autostart".content =
    # lua
    ''
      hl.on("hyprland.start", function()
        hl.exec_cmd("hyprlock")
      end)
    '';
}
