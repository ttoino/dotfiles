{
  agenix-rekey,
  mkShell,
  nix-update,
  nixd,
  nvfetcher,
  wireguard-tools,
}:
mkShell {
  packages = [
    # Create secrets
    agenix-rekey
    # Nix language server
    nixd
    # Update packages
    nix-update
    # Update sources
    nvfetcher
    # Wireguard
    wireguard-tools
  ];
}
