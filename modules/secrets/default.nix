{ ... }:
{
  home = [ ./common.nix ./home.nix ];
  nixos = [ ./common.nix ./nixos.nix ];
}
