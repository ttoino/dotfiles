{
  input = {
    kb_layout = "us,pt";
    kb_variant = "";
    kb_model = "";
    kb_options = "grp:caps_toggle";
    kb_rules = "";

    follow_mouse = 1;

    touchpad = {
      natural_scroll = false;
    };
  };

  general = {
    gaps_in = 8;
    gaps_out = 16;
    border_size = 0;

    allow_tearing = true;

    layout = "dwindle";
  };

  misc = {
    disable_hyprland_logo = true;
    disable_splash_rendering = true;
    background_color = "$surface0";
    vrr = 2;
  };

  decoration = {
    rounding = 16;

    active_opacity = 1;
    inactive_opacity = .75;
    fullscreen_opacity = 1;

    blur = {
      enabled = true;
      size = 8;
      passes = 3;
      new_optimizations = true;
    };

    shadow = {
      enabled = false;
      render_power = 1;
    };

    dim_inactive = false;
  };

  plugin.shadows-plus-plus = {
    add_shadows = 2;

    shadow_1 = {
      offset = "0 4";
      blur_radius = 4;
      spread_radius = 0;
      color = "rgba(0,0,0,0.30)";
    };

    shadow_2 = {
      offset = "0 8";
      blur_radius = 12;
      spread_radius = 6;
      color = "rgba(0,0,0,0.15)";
    };
  };

  animations = {
    enabled = true;

    bezier = [
      "myBezier, 0.05, 0.9, 0.1, 1.05"
      "linear, 0, 0, 1, 1"
    ];

    animation = [
      "windows, 1, 7, myBezier"
      "windowsOut, 1, 7, default, popin 80%"
      "fade, 1, 7, default"
      "workspaces, 1, 6, default"
    ];
  };

  dwindle = {
    pseudotile = true;
    preserve_split = true;
  };

  master = {
    new_status = "master";
  };

  xwayland = {
    force_zero_scaling = true;
  };

  ecosystem = {
    no_update_news = true;
    no_donation_nag = true;
  };
}
