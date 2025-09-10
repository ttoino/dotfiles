{ pkgs, ... }:
{
  programs.steam = {
    enable = true;

    gamescopeSession.enable = true;

    # Open ports in the firewall for Steam Remote Play
    remotePlay.openFirewall = true;
    # Open ports in the firewall for Source Dedicated Server
    dedicatedServer.openFirewall = true;
    # Open ports in the firewall for Steam Local Network Game Transfers
    localNetworkGameTransfers.openFirewall = true;

    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
}
