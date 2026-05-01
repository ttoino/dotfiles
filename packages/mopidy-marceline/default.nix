{
  lib,
  python3Packages,
  sources,

  mopidy,
  ...
}:
python3Packages.buildPythonPackage {
  inherit (sources.mopidy-marceline) pname version src;
  format = "wheel";

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
