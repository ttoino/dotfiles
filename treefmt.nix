{
  projectRootFile = "flake.nix";

  programs = {
    nixfmt.enable = true;

    prettier.enable = true;

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
