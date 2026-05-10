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
      "m3-expressive-spatial-fast, 0.42, 1.67, 0.21, 0.90"
      "m3-expressive-spatial-default, 0.38, 1.21, 0.22, 1.00"
      "m3-expressive-spatial-slow, 0.39, 1.29, 0.35, 0.98"
      "m3-expressive-effects-slow, 0.34, 0.88, 0.34, 1.00"
      "linear, 0, 0, 1, 1"
    ];

    animation = [
      "windows, 1, 5.0, m3-expressive-spatial-default, popin"
      "windowsOut, 1, 3.5, m3-expressive-spatial-fast, popin 80%"
      "windowsMove, 1, 5.0, m3-expressive-spatial-default, slide"
      "fade, 1, 3.0, m3-expressive-effects-slow"
      "workspaces, 1, 6.5, m3-expressive-spatial-slow, slide"
      "layers, 1, 5.0, m3-expressive-spatial-default, fade"
      "monitorAdded, 1, 6.5, m3-expressive-spatial-slow"
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
