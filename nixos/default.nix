{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./boot.nix
    ./catppuccin.nix
    ./disk.nix
    ./locale.nix
    ./hardware
    ./security.nix
    ./users.nix
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

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "24.05"; # Did you read the comment?
}
