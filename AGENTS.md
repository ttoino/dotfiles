# AGENTS.md — Coding Agent Guide for this Repository

## Overview

This is a **NixOS Flake-based dotfiles repository** managing full system configurations
for two NixOS machines (`bmo` — laptop, `prismo` — server) using a modular architecture
built on **Nix Flakes + Home Manager**. The primary language is **Nix**; there is no
traditional build system, test suite, or linter — everything is declarative.

## Build / Deploy Commands

```bash
# Build a specific host (CI uses this)
nix build .#nixosConfigurations.bmo.config.system.build.toplevel
nix build .#nixosConfigurations.prismo.config.system.build.toplevel

# Deploy to the current machine
sudo nixos-rebuild switch --flake .#<host>    # host = bmo | prismo
sudo nixos-rebuild test --flake .#<host>      # test without switching boot entry

# Validate the flake (evaluates all outputs, catches syntax/eval errors)
nix flake check

# Build an individual custom package
nix build .#<package>   # e.g. mopidy-marceline, mopidy-dynamic, beets-fetchartist

# Format all Nix files (uses nixfmt via the flake)
nix fmt

# Update all flake inputs (also done weekly by CI via update-flake-lock)
nix flake update

# Enter the dev shell (provides agenix-rekey, nix-update, wireguard-tools)
nix develop          # or just `direnv allow` — .envrc runs `use flake`
```

**There is no test suite.** CI (`.github/workflows/build.yml`) only builds both host
configurations. Validate changes by running `nix flake check` or building the relevant
host locally.

## Secrets

Secrets are encrypted with **agenix + agenix-rekey** (age encryption, ed25519 SSH keys).
Secret `.age` files live alongside their modules or under `secrets/` and `hosts/*/secrets/`.
Use the `agenix-rekey` CLI (available in the dev shell). Never commit plaintext secrets.

## Repository Architecture

```
flake.nix              # Entry point — declares inputs and outputs
flake.lock             # Pinned dependency versions
lib/default.nix        # Helper functions: makeHosts, getModules, joinTraits, etc.
hosts/<name>/          # Per-host config (default.nix selects traits + extra modules)
traits/<name>/         # Composable feature groups (default.nix selects modules)
modules/<name>/        # Individual config units (nixos.nix / home.nix / common.nix)
packages/<name>/       # Custom Nix package derivations
overlays/default.nix   # Nixpkgs overlays and package overrides
secrets/               # Top-level encrypted secrets
```

### Wiring: Host → Traits → Modules

- **Hosts** (`hosts/<name>/default.nix`): declare `traits` and extra `modules` lists.
- **Traits** (`traits/<name>/default.nix`): declare a `modules` list grouping modules.
- **Modules** (`modules/<name>/`): contain `nixos.nix` (system-level), `home.nix`
  (Home Manager), `common.nix` (shared), and optionally `default.nix` for extra attrs.
- `lib/default.nix` wires everything via `makeHosts`, `joinTraits`, `joinModules`.
- **Hosts**: `bmo` (Framework 16 laptop — traits: accounts, base, dev, fionna, gaming,
  graphical) and `prismo` (Intel+Nvidia server — traits: base, server).

## Nix Code Style

### Formatter

**`nixfmt`** (the official Nix formatter). Run `nix fmt` before committing. Soft line
length limit of **80 characters**.

### Module Function Signatures

Always use destructured attrsets with ellipsis: `{ pkgs, lib, ... }:`. Only destructure
parameters the module actually uses. The `args` attrset includes `inputs`, `lib`,
`modules`, `overlays`, `packages`, `traits`.

### Attribute Sets and Lists

- Opening brace/bracket on the **same line** as the key or assignment.
- One item per line for multi-item lists.
- Closing brace/bracket on its own line, aligned with the parent.
- Use `with` for concise package/module lists: `with pkgs; [ ... ]`, `with modules; [ ... ]`.

```nix
home.packages = with pkgs; [
  brightnessctl
  grimblast
  wl-clipboard
];

programs.git = {
  enable = true;
  lfs.enable = true;
};
```

### Inherit, Imports, and File Splitting

Use `inherit` to pass multiple attributes: `inherit inputs lib modules overlays packages traits;`

Larger modules split config into sub-files imported via `import ./file.nix`:

```nix
settings = (import ./options.nix) // (import ./keybinds.nix) // (import ./rules.nix);
```

### Strings

- Use `"double quotes"` for single-line strings.
- Use `'' multi-line ''` (two single-quotes) for multi-line strings and shell snippets.
- String interpolation: `${expression}`.

### Naming Conventions

- **Module directories**: `kebab-case` (e.g. `cli-apps`, `gui-apps`, `dynamic-dns`)
- **Nix variables/functions**: `camelCase` (e.g. `getModules`, `joinTraits`, `makeHosts`)
- **Nix attribute paths**: follow nixpkgs/Home Manager conventions (e.g. `programs.git.enable`)

### Priority and Merging

- `lib.mkDefault value` — set a default that can be overridden
- `lib.mkMerge [ ... ]` — merge multiple config fragments
- `lib.mkBefore content` / `lib.mkAfter content` — ordering within merged values
- `lib.mkForce value` — override unconditionally (use sparingly)

### Comments and TODOs

Inline `#` comments, used sparingly for non-obvious decisions. Use `# TODO` for
planned improvements.

### Package Overrides

Done in `overlays/default.nix` using `overrideAttrs` or `overridePythonAttrs`.

## Git Conventions

- **Main branch**: `nixos` (not `main` or `master`)
- **Author**: toino <me@toino.pt>
- **CI triggers**: push/PR to `nixos` branch

## CI / CD

- **Build** (`.github/workflows/build.yml`): builds both hosts on push/PR to `nixos`
- **Upgrade** (`.github/workflows/upgrade.yml`): weekly `flake.lock` update via
  `DeterminateSystems/update-flake-lock`
- **Dependabot** (`.github/dependabot.yml`): weekly GitHub Actions version updates
- **Cachix**: binary cache `toino`, extra pull caches: `ags`, `hyprland`, `nix-community`

