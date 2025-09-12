{ lib, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    # Not needed because of UWSM
    systemd.enable = false;

    settings = ({
      # exec-once = [ "systemctl --user start hyprpolkitagent" ];

      monitor = lib.mkDefault [
        ", preferred, auto, 1"
      ];
    })
    // (import ./apps.nix)
    // (import ./keybinds.nix)
    // (import ./options.nix)
    // (import ./rules.nix);

    plugins = with pkgs.hyprlandPlugins; [
      shadows-plus-plus
    ];
  };

  home.packages = with pkgs; [
    # cmd-polkit # TODO # Polkit agent
    brightnessctl # Screen brightness control
    grimblast # Screenshot tool
    hyprland-qtutils # Needed by hyprland
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
