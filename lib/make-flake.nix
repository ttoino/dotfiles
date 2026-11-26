{ lib }:
let
  pathsByName =
    path: name:
    (if builtins.pathExists (path + "/${name}.nix") then [ (path + "/${name}.nix") ] else [ ])
    ++ (if builtins.pathExists (path + "/${name}/default.nix") then [ (path + "/${name}") ] else [ ]);

  getDirectories =
    path: lib.attrsets.filterAttrs (name: value: value == "directory") (builtins.readDir path);

  getModule =
    args: path:
    {
      home = pathsByName path "home";
      nixos = pathsByName path "nixos";
    }
    // (lib.optionalAttrs (builtins.pathExists (path + "/default.nix")) (import path args));

  getModules =
    args: path:
    lib.attrsets.mapAttrs (name: value: getModule args (path + "/${name}")) (getDirectories path);

  getPackages =
    path: pkgs:
    lib.attrsets.mapAttrs (name: value: (pkgs.callPackage (path + "/${name}/default.nix") { })) (
      getDirectories path
    );

  join = lib.foldl' (
    acc: set:
    acc
    // set
    // lib.mapAttrs (name: value: acc.${name} ++ value) (
      lib.filterAttrs (name: value: builtins.isList value && builtins.isList (acc.${name} or null)) set
    )
  ) { };

  makeHosts =
    args: hosts:
    lib.attrsets.mapAttrs (
      name: host:
      let
        trait = join host.traits;
        module = join (
          [
            trait
            host
          ]
          ++ trait.modules or [ ]
          ++ host.modules
        );
        username = host.username or (throw "makeFlake: host ${name} does not set username");
        # Passed to both NixOS and Home Manager modules
        sharedArgs = args // {
          inherit username;
          host = name;
        };
      in
      args.inputs.nixpkgs.lib.nixosSystem {
        specialArgs = sharedArgs // {
          homeModules = module.home;
          homeArgs = (builtins.removeAttrs sharedArgs [ "lib" ]) // {
            hostLib = sharedArgs.lib;
          };
        };
        modules = module.nixos;
      }
    ) hosts;

  mergeLayers = lib.zipAttrsWith (name: join);

  # A name defined in two layers is an error
  mergeUnique =
    what:
    lib.zipAttrsWith (
      name: values:
      if builtins.length values > 1 then
        throw "makeFlake: ${what} ${name} is defined in more than one layer"
      else
        builtins.head values
    );

  systems = [
    "aarch64-darwin"
    "aarch64-linux"
    "x86_64-darwin"
    "x86_64-linux"
  ];
in
layers:
let
  base = builtins.head layers;
  top = lib.last layers;
  flakes = builtins.filter (layer: builtins.isAttrs layer && layer ? inputs) layers;

  dirsOf = what: builtins.filter builtins.pathExists (map (layer: "${layer}/${what}") layers);

  inputs =
    lib.foldl' (acc: flake: acc // builtins.removeAttrs flake.inputs [ "self" ]) { } flakes
    // {
      self = lib.last flakes;
    };

  args = {
    inherit inputs;
    lib = import ./. { inherit lib; };
    modules = mergeLayers (map (getModules args) (dirsOf "modules"));
    traits = mergeLayers (map (getModules args) (dirsOf "traits"));
    overlays = lib.concatMap (dir: import dir args) (dirsOf "overlays");
    packages = pkgs: mergeUnique "packages" (map (dir: getPackages dir pkgs) (dirsOf "packages"));
  };

  nixosConfigurations = makeHosts args (getModules args "${top}/hosts");

  perSystem =
    f:
    lib.foldl' lib.recursiveUpdate { } (
      map (system: lib.mapAttrs (name: value: { ${system} = value; }) (f system)) systems
    );
in
{
  inherit (args) lib;
  inherit nixosConfigurations;

  agenix-rekey = inputs.agenix-rekey.configure {
    userFlake = inputs.self;
    inherit nixosConfigurations;
  };
}
// perSystem (
  system:
  let
    pkgs = import inputs.nixpkgs {
      inherit system;
      inherit (args) overlays;
    };
  in
  {
    formatter = (inputs.treefmt-nix.lib.evalModule pkgs "${base}/treefmt.nix").config.build.wrapper;

    packages = args.packages pkgs;

    devShells = mergeUnique "shells" (map (dir: getPackages dir pkgs) (dirsOf "shells"));
  }
)
