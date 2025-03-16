{ inputs, ... }: {
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

  gtk.enable = true;

  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  catppuccin = {
    enable = true;
    accent = "green";
    flavor = "mocha";

    gtk.enable = true;

    cursors = {
      enable = true;
      accent = "light";
      flavor = "mocha";
    };
  };
}
