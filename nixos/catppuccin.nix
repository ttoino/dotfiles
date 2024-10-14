{ inputs, ... }: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    accent = "green";
    flavor = "mocha";
  };
}
