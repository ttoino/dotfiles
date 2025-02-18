{ pkgs, ... }:
{
  # Control media players with headset buttons
  services.mpris-proxy.enable = true;

  home.packages = with pkgs; [
    playerctl # Media player control
  ];
}
