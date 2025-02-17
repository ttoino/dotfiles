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

  hardware.enableAllFirmware = true;

  # Security
  security.polkit.enable = true;

  # Locale
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Lisbon";
  };

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
}
