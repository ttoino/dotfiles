{ inputs, pkgs, ... }:
{
  imports = [
    ./ags
    ./catppuccin.nix
    ./fonts
    ./git.nix
    ./hyprland
    ./hyprlock.nix
    ./hyprpaper.nix
    ./kitty.nix
    ./vscode.nix
    ./zsh
  ];

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home = {
    packages = with pkgs; [
      brightnessctl
      dart-sass
      grimblast
      hyprpicker
      nixpkgs-fmt
      playerctl
      prismlauncher
      wdisplays
    ];

    sessionVariables.NIXOS_OZONE_WL = "1";
    sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "wayland";

    stateVersion = "24.05";
  };
}
