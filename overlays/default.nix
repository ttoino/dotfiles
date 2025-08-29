{ inputs, packages, ... }:
[
  inputs.nix-vscode-extensions.overlays.default

  (final: prev: packages final)

  (final: prev: {
    meterial-symbols = final.stdenvNoCC.mkDerivation (rec {
      pname = "meterial-symbols";
      version = "1.0.0";

      src = final.fetchurl {
        url = "https://github.com/ttoino/${pname}/releases/download/v${version}/MeterialSymbols.zip";
        hash = "sha256-PBldiHPGtMLRnbowYmnCo45EwUCxbyYPLSw+3mL8GPQ=";
      };

      nativeBuildInputs = [ final.unzip ];

      sourceRoot = ".";

      installPhase = ''
        runHook preInstall

        install -Dm755 *.ttf -t "$out/share/fonts/TTF"
        install -Dm755 *.woff2 -t "$out/share/fonts/woff2"

        runHook postInstall
      '';
    });
  })

  (final: prev: {
    mopidy-local = prev.mopidy-local.overridePythonAttrs (oldAttrs: {
      src = final.fetchFromGitHub {
        owner = "ttoino";
        repo = "mopidy-local";
        rev = "image-sources";
        hash = "sha256-Em7Kk815lJqPrA8hFGc/q+WYA9b4XBqA6wQNO34M3C4=";
      };
    });
  })

  (final: prev: {
    mopidy-mpris = prev.mopidy-mpris.overridePythonAttrs (oldAttrs: {
      src = final.fetchFromGitHub {
        owner = "ttoino";
        repo = "mopidy-mpris";
        rev = "image-uri";
        hash = "sha256-zrRJ4hS2bSNxjeEF4OnjOeXKsnY7V0Y6iKlUws+JjoY=";
      };

      dependencies = oldAttrs.dependencies ++ [ final.python3Packages.uritools ];
    });
  })

  (final: prev: {
    mopidy-marceline = final.python3Packages.buildPythonPackage rec {
      pname = "mopidy-marceline";
      version = "0.0.4";
      format = "wheel";

      src = final.fetchurl {
        url = "https://files.pythonhosted.org/packages/py3/M/Mopidy-Marceline/mopidy_marceline-${version}-py3-none-any.whl";
        hash = "sha256-2noJkqJDxGWg14D3ilB7lWELyYgfaOtRJhrfNx7rsoI=";
      };

      propagatedBuildInputs = with final; [
        mopidy
        python3Packages.pykka
      ];

      pythonImportsCheck = [ "mopidy_marceline" ];

      doCheck = false;
    };
  })

  (final: prev: {
    python3Packages = prev.python3Packages.overrideScope (
      final': prev': {
        slskd-api = final'.buildPythonPackage rec {
          pname = "slskd-api";
          version = "0.1.5";
          pyproject = true;

          src = final.fetchFromGitHub {
            owner = "bigoulours";
            repo = pname;
            rev = "v${version}";
            hash = "sha256-Kyzbd8y92VFzjIp9xVbhkK9rHA/6KCCJh7kNS/MtixI=";
          };

          nativeBuildInputs = [ final'.setuptools-git-versioning ];

          propagatedBuildInputs = [ final'.requests ];
        };
      }
    );
  })

  (final: prev: {
    soularr = final.python3Packages.buildPythonApplication rec {
      pname = "soularr";
      version = "main";
      pyproject = false;

      src = final.fetchFromGitHub {
        owner = "mrusse";
        repo = pname;
        rev = version;
        hash = "sha256-KAFfBuz2nrn2611+LMuenTJCZX9rHA07Q/TouXb7y54=";
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
