{
  fetchFromGitHub,

  beets,
  python3Packages,
  ...
}:
python3Packages.buildPythonApplication rec {
  pname = "beets-fetchartist";
  version = "24.02.29";
  pyproject = true;

  src = fetchFromGitHub {
    repo = "beets-fetchartist";
    owner = "metermaid";
    rev = "159ed5a496d347bdfdfbdddd82753a7fa19f0b48";
    hash = "sha256-pbyXoGQIz+obA8/Wx63Y6vWL3aW1qT3Cg9n0iaplETE=";
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

  preBuild = ''
    cat > setup.py <<EOF
    from setuptools import setup

    if __name__ == "__main__":
        setup(
            name="${pname}",
            version="${version}",

            packages=['beetsplug'],
        )
    EOF
  '';
}
