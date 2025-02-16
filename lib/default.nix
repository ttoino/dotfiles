{ inputs, lib, ... }@args:
{
  importAll =
    paths:
    builtins.listToAttrs (
      builtins.map (path: {
        name = lib.strings.removeSuffix ".nix" (builtins.baseNameOf path);
        value = import path args;
      }) paths
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
      module = lib.joinModules (trait.modules ++ [ trait ] ++ host.modules);
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
            extraSpecialArgs = args;
            users.toino.imports = module.home;
          };
        }
      ];
    })
  );
}
// inputs.nixpkgs.lib
// inputs.home-manager.lib
