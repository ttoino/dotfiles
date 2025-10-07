{
  fetchFromGitHub,

  beets,
  python3Packages,
  ...
}:
python3Packages.buildPythonApplication {
  pname = "beets-fetchartist";
  version = "25.10.07";
  pyproject = true;

  src = fetchFromGitHub {
    repo = "beets-fetchartist";
    owner = "ttoino";
    rev = "d002de427f39b1bf6b7173a87c069c4a6cf9970d";
    hash = "sha256-tRlnzLkMnL3td1L2kjUeoXPmmCStuZp49TrhmGICuTU=";
  };

  nativeBuildInputs = [
    beets
  ];

  dependencies = with python3Packages; [
    pylast
    requests
  ];

  build-system = with python3Packages; [
    setuptools
  ];
}
