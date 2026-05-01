{
  lib,
  stdenvNoCC,
  sources,

  unzip,
  ...
}:
stdenvNoCC.mkDerivation {
  inherit (sources.meterial-symbols) pname version src;

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
