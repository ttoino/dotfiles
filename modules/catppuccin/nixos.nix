{ inputs, ... }:
{
  imports = [
    ./common.nix
    inputs.catppuccin.nixosModules.catppuccin
  ];
}
