{ pkgs, ... }:
{
  services = {
    mpris-proxy.enable = true; # Control media players with headset buttons
  };

  home.packages = with pkgs; [
    playerctl # Media player control
  ];
}
