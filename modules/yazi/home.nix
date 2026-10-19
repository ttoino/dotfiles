{ hostLib, lib, ... }:
let
  toYaziIcons = icons: {
    globs = [ ];
    dirs = [ ];
    files = lib.mapAttrsToList (name: text: { inherit name text; }) icons.names;
    exts = lib.mapAttrsToList (ext: text: {
      name = ext;
      inherit text;
    }) icons.extensions;
    conds = [
      {
        "if" = "dir";
        text = icons.filetype.dir;
      }
      {
        "if" = "link";
        text = icons.filetype.symlink-file;
      }
      {
        "if" = "exec";
        text = icons.filetype.executable;
      }
      {
        "if" = "fifo";
        text = icons.filetype.pipe;
      }
      {
        "if" = "sock";
        text = icons.filetype.socket;
      }
      {
        "if" = "!(dir | link | exec | fifo | sock)";
        text = icons.filetype.file;
      }
    ];
  };
in
{
  catppuccin.yazi.enable = false;

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    theme.icon = toYaziIcons hostLib.icons;
  };
}
