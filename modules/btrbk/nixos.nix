{ ... }:
{
  services.btrbk = {
    instances.btrbk = {
      onCalendar = "daily";
      settings = {
        snapshot_preserve = "14d";
        snapshot_preserve_min = "1d";
        timestamp_format = "short";
        volume."/" = {
          snapshot_dir = "/snapshots";
          subvolume."/home" = {
            snapshot_create = "always";
          };
        };
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /snapshots 0755 root root -"
  ];
}
