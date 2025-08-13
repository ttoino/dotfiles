{ ... }:
{
  # Needed to cache images
  services.gvfs.enable = true;

  # Power key is handled by cake
  services.logind.powerKey = "ignore";
}
