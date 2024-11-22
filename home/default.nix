{ inputs, pkgs, ... }:
{
  imports = [
    ./ags
    ./apps.nix
    ./catppuccin.nix
    ./fonts
    ./git.nix
    ./hypridle.nix
    ./hyprland
    ./hyprlock.nix
    ./hyprpaper.nix
    ./kitty.nix
    ./lsd.nix
    ./neovim.nix
    ./vscode.nix
    ./zsh
  ];

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  gtk.enable = true;
  qt.enable = true;
  qt.style.name = "kvantum";
  qt.platformTheme.name = "kvantum";

  home = {
    packages = with pkgs; [
      dart-sass
      nixpkgs-fmt
    ];

    sessionVariables.NIXOS_OZONE_WL = "1";
    sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "wayland";

    stateVersion = "24.05";
  };
}
