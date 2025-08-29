{
  fetchurl,
  stdenvNoCC,
  unzip,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "meterial-symbols";
  version = "1.0.0";

  src = fetchurl {
    url = "https://github.com/ttoino/${pname}/releases/download/v${version}/MeterialSymbols.zip";
    hash = "sha256-PBldiHPGtMLRnbowYmnCo45EwUCxbyYPLSw+3mL8GPQ=";
  };

  nativeBuildInputs = [ unzip ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    install -Dm755 *.ttf -t "$out/share/fonts/TTF"
    install -Dm755 *.woff2 -t "$out/share/fonts/woff2"

    runHook postInstall
  '';
}
