{
  buildDotnetModule,
  fetchYarnDeps,
  stdenv,

  curl,
  dotnet-aspnetcore_8,
  dotnet-sdk_8,
  icu,
  libmediainfo,
  openssl,
  sqlite,
  zlib,

  yarnBuildHook,
  yarnConfigHook,
  nodejs,
  sources,
  ...
}:
let
  inherit (sources.lidarr-plugins) pname src;
  version = "3.1.1.4901";

  frontend = stdenv.mkDerivation {
    pname = "${pname}-frontend";
    inherit version src;

    yarnOfflineCache = fetchYarnDeps {
      yarnLock = src + "/yarn.lock";
      hash = "sha256-Jq2O7gvB+PKcz6uDBMg7ox6/Bu+pikXH6JGuLfKG5fI=";
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
    -p:TargetFramework=net8.0
  '';
  doCheck = false;

  nugetDeps = ./deps.json;

  dotnet-sdk = dotnet-sdk_8;
  dotnet-runtime = dotnet-aspnetcore_8;
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
