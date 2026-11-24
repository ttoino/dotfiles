{ inputs, ... }:
{
  imports = [
    ./common.nix
    inputs.catppuccin.homeModules.catppuccin
  ];
}
