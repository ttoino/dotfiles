{ inputs, ... }:
{
  imports = [ inputs.disko.nixosModules.disko ];

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/ata-KINGSTON_SUV400S37240G_50026B7765001371";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "efi";
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0077"
                  "dmask=0077"
                ];
              };
            };
            swap = {
              label = "swap";
              size = "16G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
            nixos = {
              label = "nixos";
              size = "100%";
              content = {
                type = "btrfs";
                mountpoint = "/";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/home" = {
                    mountOptions = [ "compress=zstd:2" ];
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountOptions = [
                      "compress=zstd:2"
                      "noatime"
                    ];
                    mountpoint = "/nix";
                  };
                };
              };
            };
          };
        };
      };
      secondary = {
        type = "disk";
        device = "/dev/disk/by-id/ata-WDC_WD10EZRZ-00HTKB0_WD-WCC4J2FC37V6";
        content = {
          type = "gpt";
          partitions = {
            data = {
              label = "data";
              size = "100%";
              content = {
                type = "btrfs";
                mountpoint = "/data";
                mountOptions = [ "compress=zstd:2" ];
                extraArgs = [ "-f" ];
              };
            };
          };
        };
      };
    };
  };
}
