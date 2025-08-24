{ inputs, pkgs, ... }:
let
  ags = inputs.ags.packages.${pkgs.system}.default;
  cake = inputs.cake.packages.${pkgs.system}.default;
in
{
  systemd.user.services.cake = {
    Unit = {
      Description = "Cake - Styled shell for Hyprland powered by AGS";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };

    Service = {
      ExecStart = "${cake}/bin/cake";
      Restart = "on-failure";
      KillMode = "mixed";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  wayland.windowManager.hyprland.settings = {
    # It's okay to not use UWSM because these are just quickly interacting
    # with the ags daemon and not long-lived
    bind = [
      # Run menu
      "$mainMod, D, exec, ${ags}/bin/ags toggle run"

      # Logout menu
      "$mainMod, Escape, exec, ${ags}/bin/ags toggle power"
      ", XF86PowerOff, exec, ${ags}/bin/ags toggle power"
    ];

    layerrule = [
      "blur, cake-scrim"
      "order 1, cake-scrim"
      "order 1, cake-dismisser"
    ];
  };

  home.packages = with pkgs; [
    cliphist
    libnotify
  ];

  nix.settings = {
    substituters = [ "https://ags.cachix.org/" ];
    trusted-public-keys = [ "ags.cachix.org-1:naAvMrz0CuYqeyGNyLgE010iUiuf/qx6kYrUv3NwAJ8=" ];
  };

  services.cliphist.enable = true;
}
