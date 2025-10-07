pkgs:
pkgs.beets.override {
  pluginOverrides = {
    fetchartist = {
      enable = true;
      propagatedBuildInputs = [ pkgs.beetsPackages.fetchartist ];
    };
  };
}
