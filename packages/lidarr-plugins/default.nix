{
  buildDotnetModule,
  fetchFromGitHub,
  fetchYarnDeps,
  stdenv,

  curl,
  dotnet-aspnetcore_6,
  dotnet-sdk_6,
  icu,
  libmediainfo,
  openssl,
  sqlite,
  zlib,

  yarnBuildHook,
  yarnConfigHook,
  nodejs,
  ...
}:
let
  pname = "lidarr-plugins";
  version = "2.14.4.4810";

  src = fetchFromGitHub {
    owner = "lidarr";
    repo = "Lidarr";
    rev = "6e5f2f6f844daadc3a9abf4955b984da87b77dde";
    hash = "sha256-IioDoRVN3PbwDAIOxgfI+F3i4nRl8+zYB5esVTAuRgk=";
  };

  frontend = stdenv.mkDerivation {
    pname = "${pname}-frontend";
    inherit version src;

    yarnOfflineCache = fetchYarnDeps {
      yarnLock = src + "/yarn.lock";
      hash = "sha256-VfzKJY9W9VhAnwgtRdjUSsDgk0NGlxSfajPoxzCTKMQ=";
    };

    nativeBuildInputs = [
      yarnConfigHook
      yarnBuildHook
      nodejs
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out
      cp -rt $out _output/*

      runHook postInstall
    '';
  };
in
buildDotnetModule {
  inherit pname version src;

  projectFile = [
    "src/NzbDrone.Console/Lidarr.Console.csproj"
    "src/NzbDrone.Mono/Lidarr.Mono.csproj"
  ];
  executables = [ "Lidarr" ];
  dotnetFlags = ''
    -p:Version=${version} -p:AssemblyVersion=${version}
    -p:WarningLevel=0
    -p:Configuration=Release
    -p:Platform=Posix
    -p:RuntimeIdentifiers=linux-x64
    -p:TargetFramework=net6.0
  '';
  doCheck = false;

  nugetDeps = ./deps.json;

  dotnet-sdk = dotnet-sdk_6;
  dotnet-runtime = dotnet-aspnetcore_6;
  runtimeDeps = [
    curl
    icu
    libmediainfo
    openssl
    sqlite
    zlib
  ];

  postInstall = ''
    cp -rt $out/lib/${pname} ${frontend}/*
  '';
}
