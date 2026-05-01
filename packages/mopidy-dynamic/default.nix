{
  lib,
  python3Packages,
  sources,

  mopidy,
  ...
}:
python3Packages.buildPythonPackage {
  inherit (sources.mopidy-dynamic) pname version src;
  format = "wheel";

  dependencies = [
    mopidy
    python3Packages.pykka
    python3Packages.watchdog
  ];

  pythonImportsCheck = [ "mopidy_dynamic" ];

  doCheck = false;

  meta = with lib; {
    description = "Mopidy extension to generate playlists dynamically";
    homepage = "https://github.com/ttoino/mopidy-dynamic";
    license = licenses.gpl3Plus;
  };
}
