{ inputs, pkgs, ... }:
let
  ags = inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.default;
  cake = inputs.cake.packages.${pkgs.stdenv.hostPlatform.system}.default;
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

  wayland.windowManager.hyprland.extraLuaFiles."06-cake".content =
    # lua
    ''
      local mainMod = "SUPER"

      -- It's okay to not use UWSM because these are just quickly interacting
      -- with the ags daemon and not long-lived
      hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("${ags}/bin/ags toggle run"))

      -- Logout menu
      hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("${ags}/bin/ags toggle power"))
      hl.bind("XF86PowerOff", hl.dsp.exec_cmd("${ags}/bin/ags toggle power"), { locked = true })

      hl.layer_rule({ match = { namespace = "cake-scrim" }, blur = true, order = 1 })
    '';

  home.packages = with pkgs; [
    ags
    cliphist
    libnotify
  ];

  services.cliphist.enable = true;
}
