{
  windowrule = [
    # Games
    "match:class steam_app_.*, tag +game"
    "match:class [Mm]inecraft, tag +game"

    "match:tag game, immediate on"
    # FIXME: Not supported yet
    # {
    #   name = "game";
    #   "match:tag" = "game";

    #   immediate = true;
    # }

    # PiP
    "match:title discord\\.com/popout, tag +pip"
    "match:title Picture-in-Picture, tag +pip"

    "match:tag pip, float on, keep_aspect_ratio on, move monitor_w-window_w-16 monitor_h-window_h-16, size monitor_w*0.25 monitor_h*0.25, no_initial_focus on, pin on, opacity 1, no_blur on, no_dim on, opaque on"
    # FIXME: Not supported yet
    # {
    #   name = "pip";
    #   "match:tag" = "pip";

    #   "float" = true;
    #   "keep_aspect_ratio" = true;
    #   "move" = "monitor_w-window_w-16 monitor_h-window_h-16";
    #   "no_blur" = true;
    #   "no_dim" = true;
    #   "no_initial_focus" = true;
    #   "opacity" = 1;
    #   "opaque" = true;
    #   "pin" = true;
    #   "size" = "monitor_w*0.25 monitor_h*0.25";
    # }

    # Shimeji
    "match:title oneko, tag +shimeji"

    "match:tag shimeji, border_size 0, float on, no_blur on, no_focus on, no_shadow on"
    # FIXME: Not supported yet
    # {
    #   name = "shimeji";
    #   "match:tag" = "shimeji";

    #   "border_size" = 0;
    #   "float" = true;
    #   "no_blur" = true;
    #   "no_focus" = true;
    #   "no_shadow" = true;
    # }
  ];
}
