{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = ({
      exec-once =
        [ "ags run" "systemctl --user start hyprpolkitagent" "hyprlock" ];

      monitor = [
        "eDP-2, preferred, auto, 1.60"
        "desc:LG Electronics LG TV, preferred, auto-left, 1"
        "desc:Samsung Electric Company LC32G5xT H4ZR703681, preferred, auto-left, 1"
        ", preferred, auto, 1"
      ];
    }) // (import ./apps.nix) // (import ./catppuccin.nix)
      // (import ./keybinds.nix) // (import ./options.nix)
      // (import ./rules.nix);
  };
}
