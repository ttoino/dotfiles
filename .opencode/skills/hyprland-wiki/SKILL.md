---
name: hyprland-wiki
description: Look up Hyprland configuration options, dispatchers, gestures, binds, window rules, and more from the official wiki source markdown. Use this skill whenever you need to verify or audit Hyprland config.
---

## When to use

Use this skill whenever you need to:

- Verify whether a Hyprland config option exists, its type, or its default value
- Check dispatcher names and their parameters
- Validate gesture syntax and available actions
- Look up keybind syntax, window rules, workspace rules, or animations
- Audit a `hyprland.conf` or NixOS Home Manager Hyprland module for correctness

## How to fetch documentation

The authoritative source is the raw markdown in the hyprland-wiki GitHub repo.
**Always fetch the raw markdown** — the rendered wiki site returns unusable HTML.

### Base URL

```
https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/Configuring/{Page}.md
```

### Available pages

| Page | What it covers |
|------|----------------|
| `Variables` | All config sections and their options (general, decoration, input, misc, cursor, binds, animations, group, xwayland, render, opengl, ecosystem, debug, etc.). Each option is in a table with name, description, type, and default. |
| `Dispatchers` | All dispatcher names, descriptions, and parameter types. Includes workspace syntax, special workspaces, executing with rules, and `setprop`. |
| `Gestures` | The `gesture` keyword syntax: `gesture = fingers, direction, action, options`. Lists available directions (`horizontal`, `vertical`, `left`, `right`, `up`, `down`, `swipe`, `pinch`, `pinchin`, `pinchout`) and actions (`dispatcher`, `workspace`, `move`, `resize`, `special`, `close`, `fullscreen`, `float`, `cursorZoom`). |
| `Binds` | Bind syntax (`bind`, `binde`, `bindm`, `bindr`, `bindl`, etc.), submaps, global keybinds, mouse binds, and bind flags. |
| `Keywords` | Top-level keywords (`exec-once`, `source`, `env`, `monitor`, per-device input configs, etc.). |
| `Window-Rules` | Window rule syntax, match criteria, and all available rules (both static and dynamic effects like opacity, animation, blur, etc.). |
| `Workspace-Rules` | Workspace rule syntax and available rules. |
| `Animations` | Animation syntax, bezier curves, and animation tree. |
| `Monitors` | Monitor configuration, rotation, mirroring, scaling. |
| `Dwindle-Layout` | Dwindle layout options and dispatchers. |
| `Master-Layout` | Master layout options and dispatchers. |
| `Scrolling-Layout` | Scrolling layout options. |
| `Monocle-Layout` | Monocle layout options. |
| `Tearing` | Screen tearing configuration. |
| `XWayland` | XWayland settings. |
| `Permissions` | Permission control system. |
| `Using-hyprctl` | hyprctl commands and IPC. |
| `Environment-variables` | Environment variables for Hyprland and toolkits. |
| `Multi-GPU` | Multi-GPU setup. |
| `Performance` | Performance tuning tips. |
| `Uncommon-tips-&-tricks` | Switchable layouts, per-monitor configs, etc. (URL-encode `&` as `%26` in the raw URL: `Uncommon-tips-%26-tricks.md`) |

### Example fetches

To verify a config variable (e.g. `misc:vrr`):

```
WebFetch https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/Configuring/Variables.md
```

Then search the output for the relevant section (e.g. `### Misc`) and find the
option row in the table. The table columns are: name, description, type, default.

To verify a dispatcher:

```
WebFetch https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/Configuring/Dispatchers.md
```

To verify gesture syntax:

```
WebFetch https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/Configuring/Gestures.md
```

## Key things to know

### Variables page structure

The Variables page is large (~44KB). Config sections are `### Heading` level.
Subcategories use `#### Heading` with a note like `_Subcategory decoration:blur:_`.
Each section has a table of options.

### Variable types

| Type | Meaning |
|------|---------|
| `int` | integer (not a string — don't quote it in Nix) |
| `bool` | `true`/`false` |
| `float` | floating point |
| `color` | `rgba(...)`, `rgb(...)`, or legacy `0xAARRGGBB` |
| `vec2` | two floats separated by space |
| `str` | a string |
| `gradient` | `color color ... [angle]` |

### NixOS Home Manager considerations

When setting Hyprland options through Home Manager's `wayland.windowManager.hyprland.settings`:

- Integer options should be Nix integers (e.g. `vrr = 2;`), not strings
- Boolean options should be Nix booleans (`true`/`false`)
- String options should be Nix strings (`"value"`)
- The `gesture` keyword maps to a list of strings in the settings attrset
- The `bind`, `binde`, `bindm` keywords also map to lists of strings
