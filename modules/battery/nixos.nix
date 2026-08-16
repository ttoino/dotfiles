{ pkgs, ... }:
let
  ppdEnableActions = pkgs.writeShellScript "ppd-enable-actions" ''
    set -euo pipefail
    for action in amdgpu_dpm amdgpu_panel_power; do
      for _ in $(seq 1 10); do
        if ${pkgs.power-profiles-daemon}/bin/powerprofilesctl configure-action "$action" --enable; then
          break
        fi
        sleep 1
      done
    done
  '';
in
{
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # Enable PPD's built-in AMD GPU power actions
  systemd.services.power-profiles-daemon-actions = {
    description = "Enable power-profiles-daemon AMD GPU actions";
    wantedBy = [ "multi-user.target" ];
    after = [ "power-profiles-daemon.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      Restart = "on-failure";
      RestartSec = "5";
      ExecStart = ppdEnableActions;
    };
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"
    SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
  '';
}
