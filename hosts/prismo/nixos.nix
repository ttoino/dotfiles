{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel
    common-gpu-nvidia-nonprime
    common-pc
    common-pc-ssd
    ./disk.nix
    ./hardware.nix
  ];

  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "24.11";

  # Static IP
  networking = {
    usePredictableInterfaceNames = false;

    interfaces.eth0.ipv4.addresses = [
      {
        address = "192.168.1.253";
        prefixLength = 24;
      }
    ];
  };

  # Local DNS to eth0 and wg0
  services.dnsmasq.settings.host-record =
    let
      transform =
        ip:
        "${lib.strings.concatStringsSep "," config.networking.hosts."127.0.0.1"},${ip}";
    in
    [
      (transform "192.168.1.253")
      (transform "10.0.0.1")
    ];

  # Wireguard
  age.secrets = {
    wireguard-private-key = {
      rekeyFile = ../../secrets/wireguard_prismo_private_key.age;
      group = "systemd-network";
      mode = "0440";
    };
    wireguard-bmo-preshared-key = {
      rekeyFile = ../../secrets/wireguard_bmo_prismo_preshared_key.age;
      group = "systemd-network";
      mode = "0440";
    };
  };

  networking.wg-quick.interfaces.wg0 = {
    address = [ "10.0.0.1/24" ];
    listenPort = 51820;
    privateKeyFile = config.age.secrets.wireguard-private-key.path;
    peers = [
      {
        # bmo
        publicKey = "ygEXoVSG/qpGsdW2sZgtCFPX6xNELkfskv6UqQ6o+Wo=";
        presharedKeyFile = config.age.secrets.wireguard-bmo-preshared-key.path;
        allowedIPs = [ "10.0.0.2/24" ];
      }
    ];
  };
}
