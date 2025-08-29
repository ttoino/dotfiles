{
  fetchurl,
  python3Packages,

  mopidy,
  ...
}:
python3Packages.buildPythonPackage rec {
  pname = "mopidy-marceline";
  version = "0.0.4";
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/py3/M/Mopidy-Marceline/mopidy_marceline-${version}-py3-none-any.whl";
    hash = "sha256-2noJkqJDxGWg14D3ilB7lWELyYgfaOtRJhrfNx7rsoI=";
  };

  propagatedBuildInputs = [
    mopidy
    python3Packages.pykka
  ];

  pythonImportsCheck = [ "mopidy_marceline" ];

  doCheck = false;
}
