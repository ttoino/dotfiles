{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    configDir = ./config;

    systemd.enable = true;

    extraPackages = with inputs.ags.packages.${pkgs.system}; [
      apps
      battery
      bluetooth
      hyprland
      mpris
      network
      notifd
      powerprofiles
      wireplumber
    ];
  };

  wayland.windowManager.hyprland.settings = {
    # It's okay to not use UWSM because these are just quickly interacting
    # with the ags daemon and not long-lived
    bind = [
      # Run menu
      "$mainMod, D, exec, ags request 'popup toggle run'"

      # Logout menu
      "$mainMod, Escape, exec, ags request 'popup toggle power'"
      ", XF86PowerOff, exec, ags request 'popup toggle power'"
    ];

    layerrule = [
      "blur, ags-scrim"
      "order 1, ags-scrim"
      "order 1, ags-dismisser"
    ];
  };

  home.packages = with pkgs; [
    cliphist
    libnotify
  ];

  services.cliphist.enable = true;
}
