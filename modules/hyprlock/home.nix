{
  programs.hyprlock = {
    enable = true;

    settings = {
      background = [{
        path = "screenshot";
        blur_size = 8;
        blur_passes = 3;
      }];

      shape = [{
        size = "360, 56";
        color = "$base";
        rounding = -1;
        border_size = 0;

        position = "0, 0";
        halign = "center";
        valign = "center";
      }];

      input-field = [{
        size = "344, 40";
        outline_thickness = 0;
        dots_text_format = "·";
        inner_color = "$text";
        font_color = "$base";
        fade_on_empty = false;
        # fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
        # placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
        rounding = -1;
        # check_color = rgb(204, 136, 34)
        # fail_color = rgb(204, 34, 34) # if authentication failed, changes outer_color and fail message color
        # fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
        # fail_timeout = 2000 # milliseconds before fail_text and fail_color disappears
        # fail_transition = 300 # transition time in ms between normal outer_color and fail_color
        # capslock_color = -1
        # numlock_color = -1
        # bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
        # invert_numlock = false # change color if numlock is off
        # swap_font_color = false # see below

        position = "0, 0";
        halign = "center";
        valign = "center";
      }];
    };
  };

  wayland.windowManager.hyprland.settings.exec-once = [ "hyprlock" ];
}
