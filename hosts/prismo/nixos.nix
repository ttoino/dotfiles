{ inputs, ... }:
{
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel
    common-gpu-nvidia-nonprime
    common-pc
    common-pc-ssd
    ./disk.nix
    ./hardware.nix
    ./network.nix
  ];

  age.rekey.localStorageDir = ./secrets/nixos;

  # The open source driver does not support Maxwell GPUs.
  hardware.nvidia.open = false;

  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "24.11";

  # Use mullvad in qbittorrent
  services.qbittorrent.serverConfig.Preferences.Connection.Interface = "wg1";

  # Dynamic DNS
  services.cloudflare-dyndns.domains = [ "prismo.toino.pt" ];
}
