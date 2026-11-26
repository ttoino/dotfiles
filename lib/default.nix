{ lib }:
lib
// {
  makeFlake = import ./make-flake.nix { inherit lib; };
  icons = import ./icons.nix;
}
