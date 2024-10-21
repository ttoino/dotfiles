{
  "$mainMod" = "SUPER";

  bind = [
    "$mainMod, Return, exec, $terminal"
    "$mainMod, B, exec, $browser"
    "$mainMod SHIFT, B, exec, $secondary_browser"
    "$mainMod, E, exec, $file_explorer"
    "$mainMod SHIFT, E, exec, $editor"
    "$mainMod SHIFT, D, exec, $discord"

    "$mainMod, S, exec, grimblast copy"
    "$mainMod SHIFT, S, exec, grimblast copy area"

    "$mainMod CTRL, C, exec, hyprpicker -a"

    "$mainMod, D, exec, ags -t run"
    "$mainMod, P, pseudo, # dwindle"
    "$mainMod, J, togglesplit, # dwindle"

    "$mainMod, C, killactive,"
    "$mainMod SHIFT, F, togglefloating,"
    "$mainMod, F, fullscreen,"
    "$mainMod, M, fullscreen, 1"
    "$mainMod SHIFT, P, pin"

    # PiP video setup
    "$mainMod SHIFT, V, setfloating"
    "$mainMod SHIFT, V, pin"
    "$mainMod SHIFT, V, exec, hyprctl setprop active opaque toggle"
    "$mainMod SHIFT, V, resizeactive, exact 25% 25%"
    "$mainMod SHIFT, V, movewindow, r"
    "$mainMod SHIFT, V, movewindow, d"

    # Logout menu
    "$mainMod, Escape, exec, ags -t power"
    ", XF86PowerOff, exec, ags -t power"

    # Media
    "$mainMod, Period, exec, playerctl next"
    ", XF86AudioNext, exec, playerctl next"
    "$mainMod, Comma, exec, playerctl previous"
    ", XF86AudioPrev, exec, playerctl previous"
    "$mainMod, Space, exec, playerctl play-pause"
    ", XF86AudioPlay, exec, playerctl play"
    ", XF86AudioPause, exec, playerctl pause"

    # Move focus with $mainMod + arrow keys
    "$mainMod, left, movefocus, l"
    "$mainMod, right, movefocus, r"
    "$mainMod, up, movefocus, u"
    "$mainMod, down, movefocus, d"

    # Move window with $mainMod + shift + arrow keys
    "$mainMod SHIFT, left, movewindow, l"
    "$mainMod SHIFT, right, movewindow, r"
    "$mainMod SHIFT, up, movewindow, u"
    "$mainMod SHIFT, down, movewindow, d"

    # Switch workspaces with mainMod + [0-9]
    "$mainMod, 1, workspace, 1"
    "$mainMod, 2, workspace, 2"
    "$mainMod, 3, workspace, 3"
    "$mainMod, 4, workspace, 4"
    "$mainMod, 5, workspace, 5"
    "$mainMod, 6, workspace, 6"
    "$mainMod, 7, workspace, 7"
    "$mainMod, 8, workspace, 8"
    "$mainMod, 9, workspace, 9"
    "$mainMod, 0, workspace, 10"

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    "$mainMod SHIFT, 1, movetoworkspace, 1"
    "$mainMod SHIFT, 2, movetoworkspace, 2"
    "$mainMod SHIFT, 3, movetoworkspace, 3"
    "$mainMod SHIFT, 4, movetoworkspace, 4"
    "$mainMod SHIFT, 5, movetoworkspace, 5"
    "$mainMod SHIFT, 6, movetoworkspace, 6"
    "$mainMod SHIFT, 7, movetoworkspace, 7"
    "$mainMod SHIFT, 8, movetoworkspace, 8"
    "$mainMod SHIFT, 9, movetoworkspace, 9"
    "$mainMod SHIFT, 0, movetoworkspace, 10"

    # Scroll through existing workspaces with mainMod + scroll
    "$mainMod, mouse_down, workspace, e+1"
    "$mainMod, mouse_up, workspace, e-1"
  ];

  binde = [
    # Brightness
    ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
    ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"

    # Audio
    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
    ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
    ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"

    # Resize window with $mainMod + ctrl + arrow keys
    "$mainMod CTRL, left, resizeactive, -10 0"
    "$mainMod CTRL, right, resizeactive, 10 0"
    "$mainMod CTRL, up, resizeactive, 0 -10"
    "$mainMod CTRL, down, resizeactive, 0 10"
  ];

  bindm = [
    # Move/resize windows with mainMod + LMB/RMB and dragging
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];
}
