{
  programs.kitty = {
    enable = true;

    themeFile = "Catppuccin-Mocha";

    keybindings = {
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+s" = "paste_from_selection";
      "ctrl+shift+c" = "copy_to_clipboard";
      "shift+insert" = "paste_from_selection";

      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+j" = "scroll_line_down";
      "ctrl+shift+page_up" = "scroll_page_up";
      "ctrl+shift+page_down" = "scroll_page_down";
      "ctrl+shift+home" = "scroll_home";
      "ctrl+shift+end" = "scroll_end";
      "ctrl+shift+h" = "show_scrollback";

      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+n" = "new_os_window";
      "ctrl+shift+w" = "close_window";
      "ctrl+shift+]" = "next_window";
      "ctrl+shift+[" = "previous_window";
      "ctrl+shift+f" = "move_window_forward";
      "ctrl+shift+b" = "move_window_backward";
      "ctrl+shift+`" = "move_window_to_top";
      "ctrl+shift+1" = "first_window";
      "ctrl+shift+2" = "second_window";
      "ctrl+shift+3" = "third_window";
      "ctrl+shift+4" = "fourth_window";
      "ctrl+shift+5" = "fifth_window";
      "ctrl+shift+6" = "sixth_window";
      "ctrl+shift+7" = "seventh_window";
      "ctrl+shift+8" = "eighth_window";
      "ctrl+shift+9" = "ninth_window";
      "ctrl+shift+0" = "tenth_window";

      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+q" = "close_tab";
      "ctrl+shift+l" = "next_layout";
      "ctrl+shift+." = "move_tab_forward";
      "ctrl+shift+," = "move_tab_backward";
      "ctrl+shift+alt+t" = "set_tab_title";

      "ctrl+shift+equal" = "increase_font_size";
      "ctrl+shift+minus" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";
      "ctrl+shift+f6" = "set_font_size 16.0";
    };

    settings = {
      # Fonts
      "font_family" = "monospace";
      "italic_font" = "auto";
      "bold_font" = "auto";
      "bold_italic_font" = "auto";
      "font_size" = "12.0";

      "adjust_line_height" = "0";
      "adjust_column_width" = "0";
      "box_drawing_scale" = "0.001, 1, 1.5, 2";

      "narrow_symbols" = "U+1F0A0-U+1F0FF 1";

      # Cursor
      "cursor_shape" = "underline";
      "cursor_blink_interval" = "0";
      "cursor_stop_blinking_after" = "15.0";

      # Scrollback
      "scrollback_lines" = "10000";
      "scrollback_pager" = "/usr/bin/less";
      "wheel_scroll_multiplier" = "5.0";

      # URLs
      "url_style" = "double";
      "open_url_modifiers" = "ctrl+shift";
      "open_url_with" = "firefox";
      "copy_on_select" = "yes";

      # Selection
      "rectangle_select_modifiers" = "ctrl+shift";
      "select_by_word_characters" = ":@-./_~?& = %+#";

      # Mouse
      "click_interval" = "0.5";
      "mouse_hide_wait" = "0";
      "focus_follows_mouse" = "no";

      # Performance
      "repaint_delay" = "20";
      "input_delay" = "2";
      "sync_to_monitor" = "no";

      # Bell
      "visual_bell_duration" = "0.0";
      "enable_audio_bell" = "no";

      # Window
      "remember_window_size" = "no";
      "initial_window_width" = "700";
      "initial_window_height" = "400";
      "window_border_width" = "0";
      "window_margin_width" = "0";
      "window_padding_width" = "3";
      "inactive_text_alpha" = "1.0";
      "background_opacity" = "1.0";

      # Layouts
      "enabled_layouts" = "*";

      # Tabs
      "tab_bar_style" = "powerline";
      "tab_bar_edge" = "bottom";
      "tab_separator" = " ┇ ";
      "tab_powerline_style" = "slanted";
      "active_tab_font_style" = "bold";
      "inactive_tab_font_style" = "normal";

      # Shell
      "shell.close_on_child_death" = "no";
      "allow_remote_control" = "yes";
      "term" = "xterm-kitty";
    };
  };
}
