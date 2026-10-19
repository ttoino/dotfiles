{ hostLib, lib, ... }:
{
  programs.lsd = {
    enable = true;

    settings = {
      blocks = [
        "permission"
        "user"
        "group"
        "size"
        "date"
        "git"
        "name"
      ];

      sorting.dir-grouping = "first";

      total-size = true;
      hyperlink = "auto";
    };

    icons = {
      filetype = hostLib.icons.filetype;
      name = lib.mapAttrs' (name: value: lib.nameValuePair (lib.toLower name) value) hostLib.icons.names;
      extension = hostLib.icons.extensions;
    };
  };

  programs.zsh.shellAliases = {
    ls = lib.mkForce "lsd";
    lt = lib.mkForce "ls --tree -h";
    lta = lib.mkForce "lt -A";
  };
}
