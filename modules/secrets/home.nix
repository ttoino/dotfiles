{ inputs, ... }:
{
  imports = [
    ./common.nix
    inputs.agenix.homeManagerModules.default
    inputs.agenix-rekey.homeManagerModules.default
  ];
}
