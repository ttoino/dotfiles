local colors = require("themes.catppuccin")

hl.config({
    input = {
        kb_layout = "us,pt",
        kb_variant = "",
        kb_model = "",
        kb_options = "grp:caps_toggle",
        kb_rules = "",

        follow_mouse = 1,

        touchpad = {
            natural_scroll = false,
        },
    },

    general = {
        gaps_in = 8,
        gaps_out = 16,
        border_size = 0,

        allow_tearing = true,

        layout = "dwindle",
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        background_color = colors.surface0,
        vrr = 2,
    },

    decoration = {
        rounding = 16,

        active_opacity = 1,
        inactive_opacity = 0.75,
        fullscreen_opacity = 1,

        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            new_optimizations = true,
        },

        shadow = {
            enabled = false,
            render_power = 1,
        },

        dim_inactive = false,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    xwayland = {
        force_zero_scaling = true,
    },

    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
})
