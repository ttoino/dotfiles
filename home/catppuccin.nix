{ inputs, ... }: {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  gtk.enable = true;
  qt.enable = true;
  qt.style.name = "kvantum";
  qt.platformTheme.name = "kvantum";

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
