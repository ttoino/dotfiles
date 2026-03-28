{
  fetchurl,
  lib,
  stdenvNoCC,

  unzip,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "meterial-symbols";
  version = "1.3.0";

  src = fetchurl {
    url = "https://github.com/ttoino/${pname}/releases/download/v${version}/MeterialSymbols.zip";
    hash = "sha256-Du2eGckhC6lJpAhebBbAINST1OIDCn3biU/LYx+eVxU=";
  };

  nativeBuildInputs = [ unzip ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    install -Dm644 *.ttf -t "$out/share/fonts/TTF"
    install -Dm644 *.woff2 -t "$out/share/fonts/woff2"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Material Symbols compatible font for all your meter/progress needs!";
    homepage = "https://meterial.toino.pt/";
    license = licenses.asl20;
  };
}
