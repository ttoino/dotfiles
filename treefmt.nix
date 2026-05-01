{
  projectRootFile = "flake.nix";

  programs = {
    nixfmt.enable = true;

    prettier = {
      enable = true;
    };

    shfmt = {
      enable = true;
      indent_size = 4;
    };
  };

  settings = {
    excludes = [
      "_sources/*"
    ];

    formatter.shfmt.includes = [ "*.zsh" ];
  };
}
