{...}:[
  (final: prev: {
    gytmdl = prev.python3Packages.buildPythonApplication rec {
      pname = "gytmdl";
      version = "2.1.4";
      pyproject = true;

      src = prev.fetchFromGitHub {
        owner = "glomatico";
        repo = pname;
        rev = version;
        sha256 = "sha256-TnXuIz3UbUOqjUPRC7iZ+PgKcStOZ7OWKWiIvuj1ZfE=";
      };

      buildInputs = with prev.python3Packages; [
        flit
      ];

      propagatedBuildInputs = (with prev.python3Packages; [
        click
        colorama
        inquirerpy
        mutagen
        pillow
        yt-dlp
        ytmusicapi
      ]) ++ (with prev; [
        ffmpeg
        aria2
      ]);
    };
  })

  (final: prev: {
    mopidy-local = prev.mopidy-local.overrideAttrs (oldAttrs: {
      src = prev.fetchFromGitHub {
        owner = "ttoino";
        repo = "mopidy-local";
        rev = "image-sources";
        sha256 = "sha256-Em7Kk815lJqPrA8hFGc/q+WYA9b4XBqA6wQNO34M3C4=";
      };
    });
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

        nativeBuildInputs = with prev'; [ setuptools-git-versioning ];

        propagatedBuildInputs = with prev'; [ requests ];
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
        sha256 = "sha256-S+kcWKcUxvvvAv6BtWDwmeoJyN1GosFsLzOnuIg+i2k=";
      };

      propagatedBuildInputs = with prev.python3Packages; [
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
