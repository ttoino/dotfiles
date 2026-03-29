{
  fetchurl,
  lib,
  python3Packages,

  mopidy,
  ...
}:
python3Packages.buildPythonPackage rec {
  pname = "mopidy-marceline";
  version = "0.0.5";
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/py3/M/Mopidy-Marceline/mopidy_marceline-${version}-py3-none-any.whl";
    hash = "sha256-/mBGeM0dk3jk8dJWKngLX0DokJht7pE0rhrajFSWksc=";
  };

  dependencies = [
    mopidy
    python3Packages.pykka
  ];

  pythonImportsCheck = [ "mopidy_marceline" ];

  doCheck = false;

  meta = with lib; {
    description = "Mopidy extension with stylish frontend for controlling playback and browsing";
    homepage = "https://github.com/ttoino/mopidy-marceline";
    license = licenses.gpl3Plus;
  };
}
