{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings =
      ({
        exec-once = [ "systemctl --user start hyprpolkitagent" ];

        monitor = [
          "eDP-2, preferred, auto, 1.60"
          "desc:LG Electronics LG TV, preferred, auto-left, 1.25"
          "desc:Samsung Electric Company LC32G5xT H4ZR703681, preferred, auto-left, 1"
          ", preferred, auto, 1"
        ];
      })
      // (import ./apps.nix)
      // (import ./catppuccin.nix)
      // (import ./keybinds.nix)
      // (import ./options.nix)
      // (import ./rules.nix);
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

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  programs.zsh.profileExtra = ''
    if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
      exec Hyprland
    fi
  '';
}
