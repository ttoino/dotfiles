{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ./disk.nix
    ./hardware.nix
  ];

  age.rekey.localStorageDir = ./secrets/nixos;

  # Framework tools
  environment.systemPackages = with pkgs; [
    fw-ectool
    framework-tool
  ];

  # Firmware updates
  services.fwupd.enable = true;

  # Dual boot
  boot.loader.systemd-boot.windows.windows = {
    title = "Windows";
    efiDeviceHandle = "FS0";
  };

  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "24.05";

  # Wireguard
  age.secrets = {
    wireguard-private-key.rekeyFile = ../../secrets/wireguard_bmo_private_key.age;
    wireguard-prismo-preshared-key.rekeyFile = ../../secrets/wireguard_bmo_prismo_preshared_key.age;
  };

  networking.wg-quick.interfaces.wg0 = {
    address = [ "10.0.0.2/24" ];
    dns = [ "10.0.0.1" ];
    privateKeyFile = config.age.secrets.wireguard-private-key.path;
    peers = [
      {
        # prismo
        publicKey = "b08qjhwHNUDhDHDHy5CePSDWMH5mVZn73LWGCWZdgHw=";
        presharedKeyFile = config.age.secrets.wireguard-prismo-preshared-key.path;
        allowedIPs = [ "10.0.0.1/24" ];
        persistentKeepalive = 60;
        endpoint = "prismo.toino.pt:51820";
      }
    ];
  };
}
