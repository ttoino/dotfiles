{ inputs, packages, ... }:
[
  inputs.nix4vscode.overlays.default
  inputs.shadows-plus-plus.overlays.default

  (final: prev: packages final)

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
        rev = "3cf3b7c14235e1618c5f1cd0e6a5c1df3fd0d2e0";
        hash = "sha256-Em7Kk815lJqPrA8hFGc/q+WYA9b4XBqA6wQNO34M3C4=";
      };
    });
  })

  (final: prev: {
    mopidy-mpris = prev.mopidy-mpris.overridePythonAttrs (oldAttrs: {
      src = final.fetchFromGitHub {
        owner = "ttoino";
        repo = "mopidy-mpris";
        rev = "c197be548a11f3efe012a705f0f906d2cc03708b";
        hash = "sha256-zrRJ4hS2bSNxjeEF4OnjOeXKsnY7V0Y6iKlUws+JjoY=";
      };

      dependencies = oldAttrs.dependencies ++ [ final.python3Packages.uritools ];
    });
  })

  (final: prev: {
    rescrobbled = prev.rescrobbled.overrideAttrs (oldAttrs: rec {
      version = "0.9.1";

      src = final.fetchFromGitHub {
        owner = "ttoino";
        repo = "rescrobbled";
        rev = "5c7cfe22709f56f81b078dc97b5984f602e3514e";
        hash = "sha256-5pA0UxVs4paiseTEpN8Vkh1tt0FvzsIrEfE9QCuxhII=";
      };

      cargoDeps = final.rustPlatform.fetchCargoVendor {
        inherit src;
        hash = "sha256-sO5fjwjdeN/C6ZfJK0IYSSkGKbvCSvf/mZXXOkE+NLU=";
      };
    });
  })
]
