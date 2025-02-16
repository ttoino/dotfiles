{ lib, ... }:
lib.importAll [
  ./base.nix
  ./cake.nix
  ./dev.nix
  ./gaming.nix
  ./graphical.nix
  ./media.nix
]
