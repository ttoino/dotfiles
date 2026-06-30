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

  # Use mullvad in qbittorrent
  services.qbittorrent.serverConfig.Preferences.Connection.Interface = "wg1";

  # Dynamic DNS
  services.cloudflare-dyndns.domains = [ "prismo.toino.pt" ];

  # Syncthing (music sync to bmo)
  services.syncthing = {
    enable = true;
    group = "media";

    settings = {
      devices.bmo = {
        id = "GGIKOQX-EN7XCQN-27LPG56-HBDHZJH-O2V5KIE-KHYKULF-ABAY5PV-5ATL7QB";
        addresses = [ "tcp://10.0.0.2:22000" ];
      };
      folders.music = {
        path = "/data/media/music/tagged";
        devices = [ "bmo" ];
        type = "sendonly";
      };
    };
  };
}
