{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    configDir = ./config;

    # systemd.enable = true;

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

  wayland.windowManager.hyprland.settings.exec-once = [ "ags run" ];

  home.packages = with pkgs; [
    cliphist
    libnotify
  ];

  services.cliphist.enable = true;
}
