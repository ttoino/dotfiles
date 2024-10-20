{
  input = {
    kb_layout = "us,pt";
    kb_variant = "";
    kb_model = "";
    kb_options = "grp:caps_toggle";
    kb_rules = "";

    follow_mouse = "1";

    touchpad = {
      natural_scroll = "no";
    };
  };

  general = {
    gaps_in = "8";
    gaps_out = "16";
    border_size = "2";
    "col.active_border" = "rgba(89b4faee) rgba(a6e3a1ee) 45deg";
    "col.inactive_border" = "rgba(595959aa)";

    layout = "dwindle";
  };

  misc = {
    vrr = "2";
  };

  decoration = {
    rounding = "16";

    active_opacity = "1";
    inactive_opacity = ".9";
    fullscreen_opacity = "1";

    blur = {
      enabled = "yes";
      size = "8";
      passes = "1";
      new_optimizations = "on";
    };

    drop_shadow = "yes";
    shadow_range = "24";
    shadow_render_power = "3";
    "col.shadow" = "rgba(000000aa)";

    dim_inactive = "true";
    dim_strength = ".1";
  };

  animations = {
    enabled = "yes";

    bezier = [
      "myBezier, 0.05, 0.9, 0.1, 1.05"
      "linear, 0, 0, 1, 1"
    ];

    animation = [
      "windows, 1, 7, myBezier"
      "windowsOut, 1, 7, default, popin 80%"
      "border, 1, 10, default"
      "borderangle, 1, 100, linear, loop"
      "fade, 1, 7, default"
      "workspaces, 1, 6, default"
    ];
  };

  dwindle = {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = "yes"; # you probably want this
  };

  master = {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    new_status = "master";
  };

  gestures = {
    workspace_swipe = "true";
  };
}
