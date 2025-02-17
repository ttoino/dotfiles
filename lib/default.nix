{ inputs, lib, ... }@args:
{
  nameFromPath = path: lib.strings.removeSuffix ".nix" (builtins.baseNameOf path);

  importAll =
    paths:
    builtins.listToAttrs (
      builtins.map (path: {
        name = lib.nameFromPath path;
        value = import path args;
      }) paths
    );

  pathsByName =
    path: name:
    (
      if builtins.pathExists (path + "/${name}.nix") then
        [ (path + "/${name}.nix") ]
      else
        [ ]
    )
    ++ (
      if builtins.pathExists (path + "/${name}/default.nix") then
        [ (path + "/${name}") ]
      else
        [ ]
    );

  getModule =
    path:
    {
      home = (lib.pathsByName path "home") ++ (lib.pathsByName path "common");
      nixos = (lib.pathsByName path "nixos") ++ (lib.pathsByName path "common");
    }
    // (
      if builtins.pathExists (path + "/default.nix") then import path args else { }
    );

  getModules =
    path:
    lib.attrsets.mapAttrs (name: value: lib.getModule (path + "/${name}")) (
      lib.attrsets.filterAttrs (name: value: value == "directory") (
        builtins.readDir path
      )
    );

  joinTraits =
    lib.lists.foldr
      (a: b: {
        modules = a.modules ++ b.modules;
        home = a.home ++ b.home;
        nixos = a.nixos ++ b.nixos;
      })
      {
        modules = [ ];
        home = [ ];
        nixos = [ ];
      };

  joinModules =
    lib.lists.foldr
      (a: b: {
        home = a.home ++ b.home;
        nixos = a.nixos ++ b.nixos;
      })
      {
        home = [ ];
        nixos = [ ];
      };

  makeHosts = lib.attrsets.mapAttrs (
    name: host:
    let
      trait = lib.joinTraits host.traits;
      module = lib.joinModules (
        [
          trait
          host
        ]
        ++ trait.modules
        ++ host.modules
      );
    in
    (lib.nixosSystem {
      system = host.system;
      specialArgs = args;
      modules = module.nixos ++ [
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = builtins.removeAttrs args [ "lib" ];
            users.toino.imports = module.home;
          };
        }
      ];
    })
  );
}
// inputs.nixpkgs.lib
