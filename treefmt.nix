{
  projectRootFile = "flake.nix";

  programs = {
    nixfmt.enable = true;

    prettier.enable = true;

    ruff-check = {
      enable = true;
      extendSelect = [ "I" ];
    };
    ruff-format = {
      enable = true;
      lineLength = 79;
    };

    shfmt = {
      enable = true;
      indent_size = 4;
    };

    stylua = {
      enable = true;
      settings = {
        column_width = 80;
        indent_type = "Spaces";
        sort_requires.enabled = true;
      };
    };
  };

  settings = {
    excludes = [
      "_sources/*"
    ];

    formatter.shfmt.includes = [ "*.zsh" ];
  };
}
