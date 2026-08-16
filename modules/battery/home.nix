{ pkgs, ... }:
{
  systemd.user.services.power-profile-monitor = {
    Unit = {
      Description = "Notify Hyprland of power profile changes";
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = pkgs.writeShellScript "power-profile-monitor" ''
        set -euo pipefail

        notify() {
          local profile="$1"
          for sock in "$XDG_RUNTIME_DIR"/hypr/*/.socket.sock; do
            [ -S "$sock" ] || continue
            local his
            his=''${sock#$XDG_RUNTIME_DIR/hypr/}
            his=''${his%%/*}
            ${pkgs.hyprland}/bin/hyprctl eval "require(\"05-monitors\").handleProfileChange(\"$profile\")" >/dev/null 2>&1 || true
          done
        }

        ${pkgs.dbus}/bin/dbus-monitor --system "type='signal',path='/org/freedesktop/UPower/PowerProfiles',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged'" 2>/dev/null | \
        ${pkgs.gawk}/bin/awk '
          /string "org.freedesktop.UPower.PowerProfiles"/ { in_profile = 1 }
          in_profile && /string "ActiveProfile"/ { active = 1 }
          in_profile && active && /variant/ && /string "/ {
            match($0, /string "([^"]+)"/, arr)
            if (arr[1] != "") {
              print arr[1]
              fflush()
            }
            in_profile = 0
            active = 0
          }
        ' | while read -r profile; do
          notify "$profile"
        done
      '';
      Restart = "always";
      RestartSec = "5";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
