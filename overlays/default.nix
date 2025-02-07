[
  (final: prev: {
    mopidy-ytmusic = prev.mopidy-ytmusic.overrideAttrs (old: {
      src = prev.fetchFromGitHub {
        owner = "LittleFox94";
        repo = "mopidy-ytmusic";
        rev = "random-fixes";
        hash = "sha256-U4HNY5CNXs0yQ2fklVisOCIQAbF1fabD/yptEU0Joz4=";
      };

      postPatch = "";

      nativeBuildInputs = old.nativeBuildInputs ++ [
        prev.python3.pkgs.poetry-core
      ];

      propagatedBuildInputs = old.propagatedBuildInputs ++ [
        (prev.python3.pkgs.pytubefix.overrideAttrs (old: rec {
          version = "8.12.0";

          src = prev.fetchFromGitHub {
            owner = "JuanBindez";
            repo = "pytubefix";
            tag = "v${version}";
            hash = "sha256-m27iuiQDk70yHHhmayp9558S8ZYLM0/sWyCfC4VvLsQ=";
          };

          disabledTestPaths = old.disabledTestPaths + " tests/contrib/test_playlist.py tests/test_helpers.py";
        }))
      ];
    });
  })
]
