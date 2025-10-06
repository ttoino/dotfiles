{ inputs, packages, ... }:
[
  inputs.hyprland.overlays.default
  inputs.nix-vscode-extensions.overlays.default
  inputs.shadows-plus-plus.overlays.default

  (final: prev: packages final prev)

  (final: prev: {
    material-symbols = prev.material-symbols.overrideAttrs (oldAttrs: {
      version = "4.0.0-unstable-2025-08-28";

      src = final.fetchFromGitHub {
        owner = "google";
        repo = "material-design-icons";
        rev = "f5f256f04db18b1e95fccc4195c9242da2fc941b";
        hash = "sha256-YaWYTMZRvjbEG5lorQRa7sJh2xJtDYw1Sha4EQbp1BA=";
        sparseCheckout = [ "variablefont" ];
      };
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
]
