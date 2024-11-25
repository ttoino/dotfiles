{ inputs, pkgs, ... }:
{
  imports = [
    ./ags
    ./apps
    ./catppuccin.nix
    ./fonts
    ./hypridle.nix
    ./hyprland
    ./hyprlock.nix
    ./hyprpaper.nix
    ./zsh
  ];

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  home.stateVersion = "24.05";
}
