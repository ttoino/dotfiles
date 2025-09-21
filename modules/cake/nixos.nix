{ ... }:
{
  nix.settings = {
    substituters = [ "https://ags.cachix.org/" ];
    trusted-public-keys = [ "ags.cachix.org-1:naAvMrz0CuYqeyGNyLgE010iUiuf/qx6kYrUv3NwAJ8=" ];
    trusted-substituters = [ "https://ags.cachix.org/" ];
  };

  # Needed to cache images
  services.gvfs.enable = true;

  # Power key is handled by cake
  services.logind.settings.Login.HandlePowerKey = "ignore";
}
