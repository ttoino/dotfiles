{
  config,
  lib,
  inputs,
  pkgs,
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

  age.rekey.localStorageDir = ./secrets/nixos;

  # The open source driver does not support Maxwell GPUs.
  hardware.nvidia.open = false;

  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "24.11";

  # Static IP
  networking = {
    usePredictableInterfaceNames = false;

    defaultGateway.address = "192.168.1.254";

    nameservers = [
      "127.0.0.1"
      "1.1.1.1"
      "1.0.0.1"
    ];

    interfaces.eth0.ipv4.addresses = [
      {
        address = "192.168.1.1";
        prefixLength = 24;
      }
    ];
  };

  # Local DNS to eth0 and wg0
  services.dnsmasq.settings.host-record =
    let
      transform = ip: "${lib.strings.concatStringsSep "," config.networking.hosts."127.0.0.1"},${ip}";
    in
    [
      (transform "192.168.1.1")
      (transform "10.0.0.1")
    ];

  # Wireguard
  age.secrets = {
    wireguard-private-key.rekeyFile = ../../secrets/wireguard_prismo_private_key.age;
    wireguard-bmo-preshared-key.rekeyFile = ../../secrets/wireguard_bmo_prismo_preshared_key.age;
    mullvad-config.rekeyFile = ../../secrets/mullvad_prismo_config.age;
  };

  networking = {
    firewall.allowedUDPPorts = [ 51820 ];

    nat = {
      enable = true;
      enableIPv6 = true;
      externalInterface = "eth0";
      internalInterfaces = [ "wg0" ];
    };

    wg-quick.interfaces = {
      wg0 = {
        address = [ "10.0.0.1/24" ];
        listenPort = 51820;
        privateKeyFile = config.age.secrets.wireguard-private-key.path;
        postUp = ''
          ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.0.0.1/24 -o eth0 -j MASQUERADE
        '';
        preDown = ''
          ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.0.0.1/24 -o eth0 -j MASQUERADE
        '';

        peers = [
          {
            # bmo
            publicKey = "ygEXoVSG/qpGsdW2sZgtCFPX6xNELkfskv6UqQ6o+Wo=";
            presharedKeyFile = config.age.secrets.wireguard-bmo-preshared-key.path;
            allowedIPs = [ "10.0.0.2/32" ];
          }
        ];
      };
      wg1.configFile = config.age.secrets.mullvad-config.path;
    };
  };

  # Use mullvad in deluge
  services.deluge.config = {
    listen_interface = "10.73.3.79";
    outgoing_interface = "wg1";
  };

  # Dynamic DNS
  services.cloudflare-dyndns.domains = [ "prismo.toino.pt" ];
}
