{ pkgs, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "toino" ];
    };
  };

  users.users.toino.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL8sBfh3Y90/+Za1gdqVIMyhT3+QwkCOugIVRBkmoWiJ me@toino.pt"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEvn9lWmKiowT079oVpMC5rsA1m7QqvMDlg7dynabwxC JuiceSSH"
  ];

  environment.systemPackages = with pkgs; [ waypipe ];

  networking.firewall.allowedTCPPorts = [ 22 ];
}
