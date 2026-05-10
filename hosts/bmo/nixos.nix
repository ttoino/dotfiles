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

  # ROCm support for blender
  nixpkgs.config.rocmSupport = true;

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
    wireguard-private-key.rekeyFile = ./wireguard_private_key.age;
    wireguard-prismo-preshared-key.rekeyFile = ../../secrets/wireguard_bmo_prismo_preshared_key.age;

    wireguard-nm-env = {
      rekeyFile = ./wireguard_nm_env.age;
      generator = {
        dependencies = {
          inherit (config.age.secrets) wireguard-private-key wireguard-prismo-preshared-key;
        };
        script =
          {
            lib,
            decrypt,
            deps,
            ...
          }:
          ''
            printf 'WIREGUARD_PRIVATE_KEY=%s\n' "$(${decrypt} ${lib.escapeShellArg deps.wireguard-private-key.file} | tr -d '\n')"
            printf 'WIREGUARD_PSK=%s\n' "$(${decrypt} ${lib.escapeShellArg deps.wireguard-prismo-preshared-key.file} | tr -d '\n')"
          '';
      };
    };
  };

  networking.networkmanager.ensureProfiles = {
    environmentFiles = [ config.age.secrets.wireguard-nm-env.path ];

    profiles.prismo = {
      connection = {
        id = "prismo";
        type = "wireguard";
        interface-name = "wg0";
        autoconnect = "false";
      };
      ipv4 = {
        address1 = "10.0.0.2/24";
        dns = "10.0.0.1;";
        method = "manual";
        never-default = "true";
      };
      ipv6.method = "disabled";
      wireguard.private-key = "$WIREGUARD_PRIVATE_KEY";
      "wireguard-peer.b08qjhwHNUDhDHDHy5CePSDWMH5mVZn73LWGCWZdgHw=" = {
        endpoint = "prismo.toino.pt:51820";
        allowed-ips = "10.0.0.1/24;";
        persistent-keepalive = 60;
        preshared-key = "$WIREGUARD_PSK";
        preshared-key-flags = 0;
      };
    };
  };
}
