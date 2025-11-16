{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cake = {
      url = "github:ttoino/cake";
      inputs.ags.follows = "ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.52.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixos-vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.flake-utils.follows = "flake-utils";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    shadows-plus-plus = {
      url = "github:ttoino/shadows-plus-plus";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      agenix-rekey,
      flake-utils,
      home-manager,
      ...
    }@inputs:
    with rec {
      args = {
        inherit
          inputs
          lib
          modules
          overlays
          packages
          traits
          ;
      };
      hosts = lib.getModules ./hosts;
      modules = lib.getModules ./modules;
      lib = import ./lib args;
      overlays = import ./overlays args;
      packages = lib.getPackages ./packages;
      traits = lib.getModules ./traits;
    };
    {
      agenix-rekey = agenix-rekey.configure {
        userFlake = self;
        nixosConfigurations = self.nixosConfigurations;
      };

      nixosConfigurations = lib.makeHosts hosts;
    }
    // (flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages =
          (packages pkgs null)
          // (lib.attrsets.concatMapAttrs (name: config: {
            "${name}-iso" = config.config.system.build.isoImage;
          }) self.nixosConfigurations);

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            # Create secrets
            agenix-rekey.packages.${system}.default
            # Update packages
            nix-update
            # Wireguard
            wireguard-tools
          ];
        };
      }
    ));
}
