{ inputs, ... }: {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    accent = "green";
    flavor = "mocha";

    pointerCursor = {
      enable = true;
      accent = "light";
      flavor = "mocha";
    };
  };
}
