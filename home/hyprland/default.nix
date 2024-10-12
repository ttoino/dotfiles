{
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = ({
      exec-once = [ 
        "ags"
        "hyprlock"
      ];
    })
    // (import ./apps.nix)
    // (import ./catppuccin.nix)
    // (import ./keybinds.nix)
    // (import ./options.nix)
    // (import ./rules.nix);
  };
}
