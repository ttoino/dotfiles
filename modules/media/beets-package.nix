pkgs:
pkgs.python3Packages.beets.override {
  pluginOverrides = {
    fetchartist = {
      enable = true;
      propagatedBuildInputs = [ pkgs.beets-fetchartist ];
    };
  };
}
