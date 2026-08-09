{ inputs, packages, ... }:
[
  inputs.nix4vscode.overlays.default
  inputs.shadows-plus-plus.overlays.default

  (final: prev: packages final)

  (final: prev: {
    sources = import ../_sources/generated.nix {
      inherit (final)
        fetchgit
        fetchurl
        fetchFromGitHub
        dockerTools
        ;
    };

    mopidy-local = prev.mopidy-local.overridePythonAttrs (oldAttrs: {
      inherit (final.sources.mopidy-local) version src;
    });

    mopidy-mpris = prev.mopidy-mpris.overridePythonAttrs (oldAttrs: {
      inherit (final.sources.mopidy-mpris) version src;

      dependencies = oldAttrs.dependencies ++ [ final.python3Packages.uritools ];
    });
  })
]
