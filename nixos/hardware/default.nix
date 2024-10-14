{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ./generated.nix
  ];

  hardware.enableAllFirmware = true;

  # Framework tools
  environment.systemPackages = with pkgs; [
    fw-ectool
    framework-tool
  ];

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Color management
  # TODO: https://github.com/hyprwm/Hyprland/issues/4377
  services.colord.enable = true;

  # Control monitors
  # TODO: https://gitlab.com/ddcci-driver-linux/ddcci-driver-linux/-/issues/47
  # boot.extraModulePackages = with config.boot.kernelPackages; [
  #   ddcci-driver
  # ];

  # Fingerprint reader
  services.fprintd.enable = true;

  # Firmware updates
  services.fwupd.enable = true;

  # Network
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # Power management
  services.upower.enable = true;
}
