{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ./disk.nix
    ./hardware.nix   
  ];

  # Dual boot
  boot.loader.systemd-boot.windows.windows = {
    title = "Windows";
    efiDeviceHandle = "FS0";
  };

  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "24.05";
}
