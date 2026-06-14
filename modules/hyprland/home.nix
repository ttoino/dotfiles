{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    # Not needed because of UWSM
    systemd.enable = false;

    plugins = with pkgs.hyprlandPlugins; [
      shadows-plus-plus
    ];

    extraLuaFiles = {
      "00-options" = ./lua/options.lua;
      "01-animations" = ./lua/animations.lua;
      "02-apps" = {
        content =
          # lua
          ''
            local M = {}

            M.uwsm = "${pkgs.uwsm}/bin/uwsm-app"
            M.grimblast = "${pkgs.grimblast}/bin/grimblast"
            M.hyprpicker = "${pkgs.hyprpicker}/bin/hyprpicker"
            M.playerctl = "${pkgs.playerctl}/bin/playerctl"
            M.brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl"
            M.wpctl = "${pkgs.wireplumber}/bin/wpctl"

            M.launch = M.uwsm .. " --"
            M.terminal = M.uwsm .. " -T --"

            M.browser = M.launch .. " firefox.desktop"
            M.secondary_browser = M.launch .. " chromium-browser.desktop"
            M.file_explorer = M.terminal .. " yazi.desktop"
            M.editor = M.terminal .. " nvim.desktop"
            M.discord = M.launch .. " vesktop.desktop"

            M.grimblast_copy = M.grimblast .. " copy"
            M.grimblast_copy_area = M.grimblast .. " copy area"
            M.hyprpicker_cmd = M.hyprpicker .. " -a"
            M.playerctl_next = M.playerctl .. " next"
            M.playerctl_previous = M.playerctl .. " previous"
            M.playerctl_play_pause = M.playerctl .. " play-pause"
            M.brightnessctl_down = M.brightnessctl .. " set 10%-"
            M.brightnessctl_up = M.brightnessctl .. " set 10%+"
            M.wpctl_mute = M.wpctl .. " set-mute @DEFAULT_SINK@ toggle"
            M.wpctl_vol_down = M.wpctl .. " set-volume @DEFAULT_SINK@ 5%-"
            M.wpctl_vol_up = M.wpctl .. " set-volume @DEFAULT_SINK@ 5%+"

            return M
          '';
      };
      "03-keybinds" = ./lua/keybinds.lua;
      "04-rules" = ./lua/rules.lua;
      "08-plugins" = ./lua/plugins.lua;
    };
  };

  home.packages = with pkgs; [
    # cmd-polkit # TODO # Polkit agent
    brightnessctl # Screen brightness control
    grimblast # Screenshot tool
    hyprpicker # Color picker
    hyprpolkitagent # Remove this once cmd-polkit is implemented # Polkit agent
    playerctl # Media player control
    wl-clipboard # Clipboard manager
  ];

  xdg.configFile."uwsm/env".text = ''
    export NIXOS_OZONE_WL=1
    export ELECTRON_OZONE_PLATFORM_HINT=wayland
    export PROTON_ENABLE_HDR=1
    export PROTON_ENABLE_WAYLAND=1
  '';
}
