{ lib, ... }:
{
  age = {
    identityPaths = [ "/home/toino/.ssh/id_ed25519" ];
    rekey.storageMode = "local";

    generators.env =
      { decrypt, deps, ... }:
      let
        envName = name: lib.toUpper (lib.replaceStrings [ "-" ] [ "_" ] name);
      in
      lib.concatStrings (
        lib.mapAttrsToList (name: dep: ''
          printf '%s=%s\n' ${lib.escapeShellArg (envName name)} "$(${decrypt} ${lib.escapeShellArg dep.file} | tr -d '\n')"
        '') deps
      );
  };
}
