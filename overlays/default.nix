{...}:[
  (final: prev: {
    gytmdl = prev.python3Packages.buildPythonApplication rec {
      pname = "gytmdl";
      version = "2.1.4";
      format = "pyproject";

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
]
