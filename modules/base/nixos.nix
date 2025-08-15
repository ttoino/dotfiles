{ overlays, pkgs, ... }:
{
  # Use most recent kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix = {
    gc.dates = "daily";
    settings.experimental-features = "nix-command flakes";
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = overlays;
  };

  hardware.enableAllFirmware = true;

  # Security
  security.polkit.enable = true;

  # Timezone
  services.tzupdate.enable = true;

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
}
