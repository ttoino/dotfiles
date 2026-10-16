{
  inputs,
  modules,
  traits,
  ...
}:
{
  imports = [
    inputs.switchroot-nixos.nixosModules.default
  ];

  traits = with traits; [
    base
    dev
  ];

  modules = [ ];
}
