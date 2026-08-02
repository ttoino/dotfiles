{
  python3Packages,
  sources,
  ...
}:
python3Packages.buildPythonPackage {
  inherit (sources.beets-fetchartist) pname version src;
  pyproject = true;
  dontCheckPythonMetadata = true;

  nativeBuildInputs = with python3Packages; [
    beets-minimal
  ];

  dependencies = with python3Packages; [
    pylast
    requests
  ];

  build-system = with python3Packages; [
    setuptools
  ];
}
