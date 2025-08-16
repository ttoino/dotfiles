{...}:[
  (final: prev: {
    mopidy-local = prev.mopidy-local.overridePythonAttrs (oldAttrs: {
      src = prev.fetchFromGitHub {
        owner = "ttoino";
        repo = "mopidy-local";
        rev = "image-sources";
        sha256 = "sha256-Em7Kk815lJqPrA8hFGc/q+WYA9b4XBqA6wQNO34M3C4=";
      };
    });
  })
  
  (final: prev: {
    mopidy-mpris = prev.mopidy-mpris.overridePythonAttrs (oldAttrs: {
      src = prev.fetchFromGitHub {
        owner = "ttoino";
        repo = "mopidy-mpris";
        rev = "image-uri";
        sha256 = "sha256-zrRJ4hS2bSNxjeEF4OnjOeXKsnY7V0Y6iKlUws+JjoY=";
      };

      dependencies = oldAttrs.dependencies ++ [
        final.python3Packages.uritools
      ];
    });
  })

  (final: prev: {
    mopidy-marceline = prev.python3Packages.buildPythonPackage rec {
      pname = "mopidy-marceline";
      version = "0.0.4";
      format = "wheel";

      src = prev.fetchurl {
        url = "https://files.pythonhosted.org/packages/py3/M/Mopidy-Marceline/mopidy_marceline-${version}-py3-none-any.whl";
        hash = "sha256-2noJkqJDxGWg14D3ilB7lWELyYgfaOtRJhrfNx7rsoI=";
      };

      propagatedBuildInputs = with final; [
        mopidy
        python3Packages.pykka
      ];

      pythonImportsCheck = ["mopidy_marceline"];

      doCheck = false;
    };
  })

  (final: prev: {
    python3Packages = prev.python3Packages.overrideScope (final': prev': {
      slskd-api = prev'.buildPythonPackage rec {
        pname = "slskd-api";
        version = "0.1.5";
        pyproject = true;

        src = prev.fetchFromGitHub {
          owner = "bigoulours";
          repo = pname;
          rev = "v${version}";
          sha256 = "sha256-Kyzbd8y92VFzjIp9xVbhkK9rHA/6KCCJh7kNS/MtixI=";
        };

        nativeBuildInputs = [ final'.setuptools-git-versioning ];

        propagatedBuildInputs = [ final'.requests ];
      };
    });
  })

  (final: prev: {
    soularr = prev.python3Packages.buildPythonApplication rec {
      pname = "soularr";
      version = "main";
      pyproject = false;

      src = prev.fetchFromGitHub {
        owner = "mrusse";
        repo = pname;
        rev = version;
        sha256 = "";
      };

      propagatedBuildInputs = with final.python3Packages; [
        music-tag
        pyarr
        slskd-api
      ];

      installPhase = ''
        install -Dm755 ${pname}.py $out/bin/${pname}
      '';
    };
  })
]
