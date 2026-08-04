{
  lib,
  overlays,
  pkgs,
  ...
}:
{
  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "24.05";

  # Use most recent kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings = {
    experimental-features = "nix-command flakes";

    substituters = [
      "https://nix-community.cachix.org"
      "https://toino.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "toino.cachix.org-1:CYUAqEsSPuH1mEtyiqq7nGdYq7LGD9nXQdvdQbNuGR8="
    ];
    trusted-substituters = [
      "https://nix-community.cachix.org"
      "https://toino.cachix.org"
    ];
    trusted-users = [ "toino" ];
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = overlays;
  };

  hardware.enableAllFirmware = true;

  # Security
  security.polkit.enable = true;

  # Timezone
  time.timeZone = lib.mkDefault "Europe/Lisbon";

  # Locale
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      # LC_* variables
    };
  };

  # Networking
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Printing
  services.printing.enable = true;

  # Nix-ld
  programs.nix-ld.enable = true;
}
