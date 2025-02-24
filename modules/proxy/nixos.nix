{ ... }:
{
  services.caddy = {
    enable = true;
    extraConfig = "certIssuer internal";
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
