{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services.displayManager.defaultSession = "hyprland";

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
  };

  # Let the monitors lua module own lid handling
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };

  services.acpid = {
    enable = true;
    lidEventCommands = ''
      sock=$(${pkgs.coreutils}/bin/ls /run/user/*/hypr/*/.socket.sock 2>/dev/null | ${pkgs.coreutils}/bin/head -n1)
      [ -S "$sock" ] || exit 0
      uid=''${sock#/run/user/}; uid=''${uid%%/*}
      his=''${sock#/run/user/$uid/hypr/}; his=''${his%%/*}
      user=$(${pkgs.coreutils}/bin/id -un "$uid")
      state=''${1##* }
      ${pkgs.util-linux.bin}/bin/runuser -u "$user" -- \
        ${pkgs.coreutils}/bin/env \
          XDG_RUNTIME_DIR=/run/user/$uid \
          HYPRLAND_INSTANCE_SIGNATURE="$his" \
        ${pkgs.hyprland}/bin/hyprctl eval "require(\"05-monitors\").handleLidEvent(\"$state\")" >/dev/null 2>&1
    '';
  };
}
