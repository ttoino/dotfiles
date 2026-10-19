{ lib, ... }:
{
  age = {
    rekey = {
      storageMode = "local";
      masterIdentities = [ "/home/toino/.ssh/id_ed25519" ];
    };

    generators.env =
      { decrypt, deps, ... }:
      let
        envName = name: lib.toUpper (lib.replaceStrings [ "-" ] [ "_" ] name);
      in
      lib.concatStrings (
        lib.mapAttrsToList (name: dep: ''
          printf '%s="%s"\n' ${lib.escapeShellArg (envName name)} "$(${decrypt} ${lib.escapeShellArg dep.file} | tr -d '\n')"
        '') deps
      );

    generators.pbkdf2 =
      {
        pkgs,
        lib,
        decrypt,
        deps,
        ...
      }:
      let
        dep = lib.head deps;
      in
      ''
        ${lib.getExe pkgs.python3} -c "
        import base64, hashlib, os, sys
        password = sys.stdin.read().rstrip('\n').encode('utf-8')
        salt = os.urandom(16)
        dk = hashlib.pbkdf2_hmac('sha512', password, salt, 100000)
        print(f'@ByteArray({base64.b64encode(salt).decode()}:{base64.b64encode(dk).decode()})')
        " < <(${decrypt} ${lib.escapeShellArg dep.file})
      '';
  };
}
