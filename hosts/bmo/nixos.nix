{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.switchroot-nixos.nixosModules.default
  ];

  # The base trait enables GRUB + latest kernel; the Switch needs U-Boot + L4T kernel
  boot.loader.grub.enable = lib.mkForce false;
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_4_9-l4t.cross-compiled;

  age.rekey.localStorageDir = ./secrets/nixos;

  users.users.toino.extraGroups = [
    "video"
    "audio"
  ];

  services.openssh.settings.PermitRootLogin = "yes";

  nixpkgs = {
    system = "aarch64-linux";
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "nvidia-x11"
        "nvidia-settings"
      ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/SWR-NIXOS";
    fsType = "ext4";
  };
}
