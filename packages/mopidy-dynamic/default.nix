{
  fetchurl,
  lib,
  python3Packages,

  mopidy,
  ...
}:
python3Packages.buildPythonPackage rec {
  pname = "mopidy-dynamic";
  version = "1.0.0";
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/py3/M/Mopidy-Dynamic/mopidy_dynamic-${version}-py3-none-any.whl";
    hash = "sha256-kcUZpLg3/nhcWN5Y91umD1yON1j0Y/arMr2J2gGNGBY=";
  };

  propagatedBuildInputs = [
    mopidy
    python3Packages.pykka
    python3Packages.watchdog
  ];

  pythonImportsCheck = [ "mopidy_dynamic" ];

  doCheck = false;

  meta = with lib; {
    description = "Mopidy extension to generate playlists dynamically";
    homepage = "https://github.com/ttoino/mopidy-dynamic";
    licenses = licenses.gpl3Plus;
  };
}
