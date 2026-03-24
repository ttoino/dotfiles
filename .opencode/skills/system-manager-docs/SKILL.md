---
name: system-manager-docs
description: Look up System Manager configuration options, CLI commands, module options, and usage patterns from the official documentation. Use this skill whenever you need to verify or audit system-manager configurations.
---

## When to use

Use this skill whenever you need to:

- Verify System Manager module options (environment, systemd, nixpkgs, etc.)
- Check CLI command syntax and available subcommands
- Understand configuration patterns and project structure
- Look up supported platforms and compatibility
- Validate NixOS module imports for System Manager
- Find examples for services, timers, tmpfiles, and other systemd units

## What is System Manager?

System Manager is a tool to configure non-NixOS Linux machines using NixOS-style declarative configurations. Unlike NixOS, it doesn't require replacing the entire OS - it manages a subset of the system (packages, systemd services, /etc files) through an immutable layer.

Think of it as "Home Manager for the entire system" - whereas Home Manager manages user environments, System Manager manages the system-level configuration.

## How to fetch documentation

The authoritative source is the raw markdown in the system-manager GitHub repo under `docs/site/`.

### Base URL

```
https://raw.githubusercontent.com/numtide/system-manager/main/docs/site/{path}.md
```

### Available pages

| Page | Path | What it covers |
|------|------|----------------|
| **Module Options** | `reference/modules.md` | All configuration options: `environment.systemPackages`, `environment.etc`, `systemd.services`, `systemd.tmpfiles`, `nixpkgs.*`, `system-manager.*` |
| **CLI Commands** | `reference/cli.md` | All subcommands: `init`, `switch`, `build`, `activate`, `deactivate`, `pre-populate`, `register`, plus flags like `--sudo` |
| **All Options** | `reference/all-options.md` | Comprehensive option reference with types and defaults |
| **Configuration Patterns** | `reference/configuration.md` | Project organization, multi-file setups, flakes structure |
| **Supported Platforms** | `reference/supported-platforms.md` | Distribution compatibility (Ubuntu, NixOS, `allowAnyDistro`) |
| **Getting Started** | `tutorials/getting-started.md` | Installation, init command, first configuration |
| **First Service** | `tutorials/first-service.md` | Creating systemd services |
| **Installation** | `how-to/install.md` | Installation methods |
| **Rollback** | `how-to/rollback.md` | Rolling back changes |
| **FAQ** | `faq.md` | Common questions and troubleshooting |

### Example fetches

To verify a module option (e.g., `systemd.services`):

```
WebFetch https://raw.githubusercontent.com/numtide/system-manager/main/docs/site/reference/modules.md
```

Then search for the relevant section (e.g., `## systemd.services`).

To check CLI commands:

```
WebFetch https://raw.githubusercontent.com/numtide/system-manager/main/docs/site/reference/cli.md
```

To check supported platforms:

```
WebFetch https://raw.githubusercontent.com/numtide/system-manager/main/docs/site/reference/supported-platforms.md
```

## Key module options

### nixpkgs

| Option | Type | Required | Description |
|--------|------|----------|-------------|
| `nixpkgs.hostPlatform` | string | **Yes** | Target platform (e.g., `"x86_64-linux"`) |
| `nixpkgs.buildPlatform` | string | No | Build platform (defaults to host) |
| `nixpkgs.overlays` | list | No | Nixpkgs overlays |
| `nixpkgs.config` | attrset | No | Nixpkgs config (e.g., `{ allowUnfree = true; }`) |

### environment

| Option | Type | Description |
|--------|------|-------------|
| `environment.systemPackages` | list of packages | Packages installed system-wide at `/run/system-manager/sw/bin/` |
| `environment.pathsToLink` | list of strings | Paths to link from packages (default: `[ "/bin" ]`) |
| `environment.etc` | attrset of submodules | Files under `/etc` |

#### environment.etc options

Each entry under `environment.etc` supports:

| Option | Type | Description |
|--------|------|-------------|
| `enable` | boolean | Whether to create the file |
| `text` | string/null | File content (mutually exclusive with `source`) |
| `source` | path | Path to source file |
| `target` | string | Target path relative to `/etc` |
| `mode` | string | `"symlink"` or octal mode (e.g., `"0644"`) |
| `uid`/`gid` | integer | Numeric owner IDs (when mode is not symlink) |
| `user`/`group` | string | Owner names (takes precedence over uid/gid) |

### systemd

| Option | Type | Description |
|--------|------|-------------|
| `systemd.package` | package | Systemd package to use |
| `systemd.globalEnvironment` | attrset | Environment variables for all units |
| `systemd.services` | attrset of services | Service unit definitions |
| `systemd.timers` | attrset of timers | Timer unit definitions |
| `systemd.sockets` | attrset of sockets | Socket unit definitions |
| `systemd.targets` | attrset of targets | Target unit definitions |
| `systemd.paths` | attrset of paths | Path unit definitions |
| `systemd.mounts` | list of mounts | Mount unit definitions |
| `systemd.automounts` | list of automounts | Automount unit definitions |
| `systemd.slices` | attrset of slices | Slice unit definitions |
| `systemd.generators` | attrset of paths | Generator symlinks |
| `systemd.shutdown` | attrset of paths | Shutdown executable symlinks |
| `systemd.tmpfiles.rules` | list of strings | tmpfiles.d(5) rules |
| `systemd.tmpfiles.settings` | nested attrset | Structured tmpfiles config |
| `systemd.tmpfiles.packages` | list of packages | Packages with tmpfiles.d configs |

### system-manager

| Option | Type | Description |
|--------|------|-------------|
| `system-manager.allowAnyDistro` | boolean | Bypass distribution checks for untested distros |

## CLI commands

| Command | Description |
|---------|-------------|
| `init` | Create initial configuration files (`flake.nix`, `system.nix`) |
| `switch` | Build and activate configuration (with rollback on failure) |
| `build` | Build configuration without activating |
| `activate` | Activate previously built configuration |
| `deactivate` | Remove system-manager configuration |
| `pre-populate` | Prepare system without full activation |
| `register` | Register system-manager as the system config manager |
| `sudo` | Run command with elevated privileges |

Common flags:
- `--sudo` - Run with sudo (preserves PATH)
- `--extra-experimental-features 'nix-command flakes'` - Enable flakes if not in nix.conf

## Common patterns

### Basic flake structure

```nix
{
  description = "System Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, system-manager, ... }: {
    systemConfigs.default = system-manager.lib.makeSystemConfig {
      modules = [ ./system.nix ];
    };
  };
}
```

### Creating a systemd service

```nix
systemd.services.myservice = {
  description = "My Service";
  wantedBy = [ "system-manager.target" ];
  serviceConfig = {
    Type = "oneshot";
    ExecStart = "${pkgs.hello}/bin/hello";
  };
};
```

### Managing /etc files

```nix
environment.etc."myapp/config.conf" = {
  text = "setting = value";
  mode = "0644";
};
```

## Key things to know

### File mode syntax

- `"symlink"` - Create symlink to Nix store (default, immutable)
- `"0644"` - Copy file with mode (owner read/write, group/others read)
- `"0755"` - Copy with execute permissions

### Service activation

Services must specify `wantedBy = [ "system-manager.target" ];` to start on activation.

### Path requirements

Installed packages are available at `/run/system-manager/sw/bin/`, not directly in `PATH`. System Manager updates `/etc/profile.d/` to add this to PATH.

### Distribution support

- **Supported**: Ubuntu, NixOS
- **Experimental**: Other distros (set `system-manager.allowAnyDistro = true;`)

### Comparison to NixOS

System Manager only manages:
- System packages (via `environment.systemPackages`)
- `/etc` files
- Systemd units (services, timers, tmpfiles, etc.)
- Nix configuration

It does NOT manage:
- Kernel/bootloader
- Filesystems
- Users/groups (use regular system tools)
- Hardware configuration
