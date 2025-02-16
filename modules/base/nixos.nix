{ pkgs, ... }:
{
  # Use most recent kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix = {
    settings.experimental-features = "nix-command flakes";
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;
}
