{ pkgs, inputs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ./generated.nix
  ];

  # Framework tools
  environment.systemPackages = with pkgs; [
    fw-ectool
    framework-tool
  ];

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Color management
  services.colord.enable = true;

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
