{ inputs, outputs, config, lib, pkgs, ... }: {
  imports = [
    ./boot.nix
    ./catppuccin.nix
    ./gaming.nix
    ./hardware
    ./locale.nix
    ./security.nix
    ./users.nix
    ./virtualization.nix
    ./zsh.nix
  ];

  # Use most recent kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = "nix-command flakes";
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = outputs.overlays;

  environment.systemPackages = with pkgs; [ vim wget ];

  programs.hyprland.enable = true;
  services.gvfs.enable = true;

  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "24.05"; # Did you read the comment?
}
