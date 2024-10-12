{ inputs, pkgs, ... }:
{
  imports = [
    ./ags
    ./catppuccin.nix
    ./fonts
    ./git.nix
    ./hyprland
    ./vscode.nix
  ];

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home = {
    packages = with pkgs; [
      brightnessctl
      dart-sass
      nixpkgs-fmt
      prismlauncher
    ];

    sessionVariables.NIXOS_OZONE_WL = "1";
    sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "wayland";

    stateVersion = "24.05";
  };
}
