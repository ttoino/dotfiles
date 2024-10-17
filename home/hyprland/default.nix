{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = ({
      exec-once = [
        "ags"
        "soteria"
        "hyprlock"
      ];

      monitor = [
        "eDP-2, preferred, auto, 1.60"
        "desc:Hewlett Packard HP P221 3CQ34809BD, preferred, auto-left, 1"
        ", preferred, auto, 1"
      ];
    })
    // (import ./apps.nix)
    // (import ./catppuccin.nix)
    // (import ./keybinds.nix)
    // (import ./options.nix)
    // (import ./rules.nix);
  };
}
