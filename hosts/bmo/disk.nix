{ inputs, ... }:
{
  imports = [ inputs.disko.nixosModules.disko ];

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme1n1";
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
              size = "64G";
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
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            # There are more, but we only care about these
            windows = {
              label = "windows";
              content = {
                type = "filesystem";
                format = "ntfs";
                mountpoint = "/windows";
              };
            };
            data = {
              label = "data";
              content = {
                type = "filesystem";
                format = "ntfs";
                mountpoint = "/data";
              };
            };
          };
        };
      };
    };
  };
}
