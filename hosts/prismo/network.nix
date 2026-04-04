{ config, lib, ... }:
{
  # systemd-networkd configuration
  systemd.network = {
    enable = true;

    netdevs."20-wg0" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "wg0";
      };
      wireguardConfig = {
        ListenPort = 51820;
        PrivateKeyFile = config.age.secrets.wireguard-private-key.path;
      };
      wireguardPeers = [
        {
          # bmo
          PublicKey = "ygEXoVSG/qpGsdW2sZgtCFPX6xNELkfskv6UqQ6o+Wo=";
          PresharedKeyFile = config.age.secrets.wireguard-bmo-preshared-key.path;
          AllowedIPs = [ "10.0.0.2/32" ];
        }
        {
          PublicKey = "5YQrqvKcHAgC+I1qDrPdW62GkqY1CfI7lC9gi0EiVhE=";
          AllowedIPs = [ "10.0.0.3/32" ];
        }
        {
          PublicKey = "jfrJuOvt1VmvgJez0tdsriIxgKEZmheZfo4UhpLf1yk=";
          AllowedIPs = [ "10.0.0.4/32" ];
        }
        {
          PublicKey = "vFnSrY7VAi5d8QJiJlXJIXDUWK+zPJ0qGDr+uaUd5Wo=";
          AllowedIPs = [ "10.0.0.5/32" ];
        }
        {
          PublicKey = "jiqxW8n0zeqvh0AenIJGRep18JAJ4Xo72iP+rsU/Y3Q=";
          AllowedIPs = [ "10.0.0.6/32" ];
        }
        {
          PublicKey = "GCK6UlCQw58xtcrW9JTM4gLcTv2P1iHNnoOJoy25RUI=";
          AllowedIPs = [ "10.0.0.28/32" ];
        }
        {
          PublicKey = "wMBMd4FFgtI6G1bKhUqnTKhKMHsG9rPWJG0cIKFVkSE=";
          AllowedIPs = [ "10.0.0.82/32" ];
        }
        {
          PublicKey = "5yB+a8HBDpu9NngU5et3rx49hNBZWESVHuKyapvX9VA=";
          AllowedIPs = [ "10.0.0.128/32" ];
        }
      ];
    };

    networks = {
      "10-eth0" = {
        matchConfig.Name = "eth0";
        address = [ "192.168.1.1/24" ];
        routes = [
          { Gateway = "192.168.1.254"; }
        ];
        dns = [
          "127.0.0.1"
          "1.1.1.1"
          "1.0.0.1"
        ];
        linkConfig.RequiredForOnline = "routable";
      };

      "30-wg0" = {
        matchConfig.Name = "wg0";
        address = [ "10.0.0.1/24" ];
        networkConfig = {
          IPv4Forwarding = true;
          IPv6Forwarding = true;
        };
        linkConfig.RequiredForOnline = "no";
      };
    };
  };

  networking = {
    # Disable scripted networking (we're using networkd)
    useNetworkd = true;
    useDHCP = false;

    # Interface naming - keep eth0 predictable naming disabled
    usePredictableInterfaceNames = false;

    # Firewall configuration
    firewall.allowedUDPPorts = [ 51820 ];

    # NAT configuration for WireGuard
    nat = {
      enable = true;
      enableIPv6 = true;
      externalInterface = "eth0";
      internalInterfaces = [ "wg0" ];
    };

    # Mullvad VPN (wg1) - using wg-quick with configFile
    # Keeping as wg-quick since Mullvad provides the full config
    wg-quick.interfaces.wg1.configFile = config.age.secrets.mullvad-config.path;
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

  age.secrets = {
    wireguard-private-key = {
      rekeyFile = ./wireguard_private_key.age;
      mode = "640";
      owner = "systemd-network";
      group = "systemd-network";
    };
    wireguard-bmo-preshared-key = {
      rekeyFile = ../../secrets/wireguard_bmo_prismo_preshared_key.age;
      mode = "640";
      owner = "systemd-network";
      group = "systemd-network";
    };
    mullvad-config.rekeyFile = ./mullvad_config.age;
  };
}
