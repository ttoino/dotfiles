{ ... }:
{
  # Needed to cache images
  services.gvfs.enable = true;

  # Power key is handled by ags
  services.logind.powerKey = "ignore";
}
