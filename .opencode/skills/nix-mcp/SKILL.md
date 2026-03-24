---
name: nix-mcp
description: Query Nix packages, NixOS options, Home Manager options, and Nix ecosystem resources. Use this skill whenever you need to look up Nix packages, verify configuration options, or check Nix syntax.
---

## When to use

Use this skill whenever you need to:

- Look up Nix packages (search packages by name or description)
- Get detailed information about a specific package
- Verify NixOS configuration options and their valid values
- Verify Home Manager options and their valid values
- Check Darwin (nix-darwin) options
- Query Nixvim options
- Look up FlakeHub packages
- Search Noogle (Nix function documentation)
- Browse NixHub package versions
- Check NixOS Wiki or nix.dev documentation
- Inspect flake inputs
- Check binary cache availability

## How to query

Use the `nix_nix` tool with the appropriate `action` and `source` parameters.

### Available actions

| Action | Description | Best for |
|--------|-------------|----------|
| `search` | Search for packages/options | Finding packages by keyword |
| `info` | Get detailed info about a specific item | Package details, option docs |
| `stats` | Get statistics about a source | Overview of available data |
| `options` | List or search options (Home Manager/Darwin/nixvim only) | Config validation |
| `channels` | List available channels | Finding channel names |
| `flake-inputs` | Read flake.lock or specific inputs | Dependency inspection |
| `cache` | Check binary cache for packages | Verifying cache availability |

### Available sources

| Source | What it covers | Actions supported |
|--------|----------------|-------------------|
| `nixos` | NixOS packages and options | search, info, stats, channels |
| `home-manager` | Home Manager packages and options | search, info, stats, options, channels |
| `darwin` | nix-darwin options | options |
| `flakes` | Nix flakes ecosystem | info |
| `flakehub` | FlakeHub packages | search, info, stats |
| `nixvim` | Nixvim options | options |
| `wiki` | NixOS Wiki | search, info |
| `nix-dev` | nix.dev documentation | search, info |
| `noogle` | Nix function documentation (Noogle) | search, info |
| `nixhub` | NixHub package versions | search, info |

### Common parameters

| Parameter | Description | Example |
|-----------|-------------|---------|
| `query` | Search term, package name, or option path | `"git"`, `"services.nginx"` |
| `action` | The action to perform (see table above) | `"search"`, `"options"` |
| `source` | Which source to query (see table above) | `"nixos"`, `"home-manager"` |
| `type` | For `nixos`/`home-manager`: `packages`, `options`, `programs` | `"packages"` |
| `channel` | Channel to use (`unstable` or `stable`) | `"unstable"` |
| `limit` | Max results to return (1-100, default 20) | `50` |

## Example queries

### Search for packages

```
nix_nix:0 {"action": "search", "source": "nixos", "query": "neovim", "limit": 10}
```

### Get package info

```
nix_nix:1 {"action": "info", "source": "nixos", "query": "git"}
```

### Search Home Manager options

```
nix_nix:2 {"action": "options", "source": "home-manager", "query": "programs.git"}
```

### Check NixOS options

```
nix_nix:3 {"action": "info", "source": "nixos", "type": "options", "query": "services.nginx.enable"}
```

### List nixvim options

```
nix_nix:4 {"action": "options", "source": "nixvim", "query": "plugins"}
```

### Search Noogle for Nix functions

```
nix_nix:5 {"action": "search", "source": "noogle", "query": "mapAttrs"}
```

### Check FlakeHub

```
nix_nix:6 {"action": "search", "source": "flakehub", "query": "home-manager"}
```

### Read flake inputs

```
nix_nix:7 {"action": "flake-inputs", "query": "nixpkgs"}
```

### Check binary cache

```
nix_nix:8 {"action": "cache", "query": "hello", "system": "x86_64-linux"}
```

## Package version history

To check version history of a specific package, use `nix_nix_versions`:

```
nix_nix_versions:9 {"package": "nodejs", "limit": 10}
```

This returns available versions from NixHub.io.

## Key things to know

### Option browsing limitations

The `options` action is **only** available for:
- `home-manager`
- `darwin` (nix-darwin)
- `nixvim`

For NixOS options, use `action: "info"` with `type: "options"` instead.

### Channel selection

- Use `channel: "unstable"` for the latest packages (default)
- Use `channel: "stable"` or `channel: "25.05"` for stable releases
- Some sources (like `nixvim`, `noogle`) don't use channels

### Result interpretation

Search results typically include:
- **Package name** - The attribute path (e.g., `nixpkgs.git`)
- **Version** - Package version
- **Description** - Brief description
- **License** - License information
- **Homepage** - Project URL

Option results include:
- **Option path** - Full option name
- **Type** - Option type (bool, string, int, etc.)
- **Default** - Default value
- **Description** - Full documentation

### Common patterns

**Verifying a configuration option exists:**
```
action: "options", source: "home-manager", query: "programs.kitty.settings"
```

**Finding packages by function:**
```
action: "search", source: "nixos", query: "pdf", type: "packages"
```

**Checking if an option is valid in Home Manager:**
```
action: "options", source: "home-manager", query: "nix.gc"
```

## Troubleshooting

**"No options found" for NixOS:**
Use `action: "info"` instead of `action: "options"` for NixOS.

**Empty results:**
Try broadening your query or using a different source.

**Package not found:**
The package might be in a different channel or named differently. Try searching with partial names.
