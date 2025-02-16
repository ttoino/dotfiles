{ traits, ... }:
{
  system = "x86_64-linux";

  traits = with traits; [
    base
    cake
    dev
    gaming
    graphical
  ];

  modules = [ ];

  nixos = [
    ./common.nix
    ./nixos.nix
  ];

  home = [
    ./common.nix
    ./home.nix
  ];
}
