{ inputs, ... }:
{
  imports = [
    ./common.nix
    inputs.agenix.nixosModules.default
    inputs.agenix-rekey.nixosModules.default
  ];
}
