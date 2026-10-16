{ pkgs, lib, ... }:
{
  nixpkgs = {
    system = "aarch64-linux";
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "nvidia-x11"
        "nvidia-settings"
      ];
  };

  networking.hostName = "bmo";

  users.users.toino = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ];
  };

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/SWR-NIXOS";
    fsType = "ext4";
  };
}
