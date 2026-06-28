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
- Audit a `hyprland.lua` config or a NixOS Home Manager Hyprland module

## Background: config is Lua since 0.55

Hyprland deprecated `hyprlang` in favor of **Lua**. The entry point is
`$XDG_CONFIG_HOME/hypr/hyprland.lua` and the config is plain Lua calling the
`hl.*` API. Split config across files with `require("name")` — each `require`'d
file runs in an **isolated lua scope**, so errors in one file don't kill the
others. Use `pcall(require, "name")` for optional modules.

The legacy hyprlang `key = value` syntax (and Home Manager's
`wayland.windowManager.hyprland.settings` attrset) no longer applies unless a
config pins `configType = "hyprlang"`. When `configType = "lua"`, everything is
expressed as `hl.*` calls.

## How to fetch documentation

The authoritative source is the raw markdown in the hyprland-wiki GitHub repo.
**Always fetch the raw markdown** — the rendered wiki site returns unusable
HTML.

### Base URL

```
https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/Configuring/
```

Pages are **nested in subdirectories**, not flat. Always prefix the page with
its directory (see table below). Spaces in directory names must be URL-encoded
as `%20`.

### Available pages

| Page                                              | What it covers                                                                                                                                                                                                  |
| ------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Start`                                           | Lua config overview, `require()`/error behavior, LSP stub setup, multi-file config. Read this first when scripting.                                                                                            |
| `Example-configurations`                          | Link to the example `hyprland.lua`.                                                                                                                                                                             |
| `Basics/Variables`                                | All config sections and their options (general, decoration, input, misc, cursor, binds, animations, group, xwayland, render, opengl, ecosystem, debug, layout, quirks). Each option: name, description, type, default. |
| `Basics/Dispatchers`                              | All `hl.dsp.*` dispatchers and their parameter shapes. Includes workspace selectors, special workspaces, executing with rules, and `set_prop`.                                                                 |
| `Basics/Monitors`                                 | `hl.monitor()` spec, positioning, scaling, mirroring, rotation, color management, reserved areas.                                                                                                             |
| `Basics/Window-Rules`                             | `hl.window_rule()` syntax, match props, static/dynamic effects, tags, `group` options, layer rules via `hl.layer_rule()`.                                                                                      |
| `Basics/Workspace-Rules`                          | `hl.workspace_rule()` syntax, workspace selectors, and available rules (gaps, border, layout, persistence, on_created_empty).                                                                                  |
| `Basics/Binds`                                    | `hl.bind()` syntax, submaps, global/dbus keybinds, mouse binds, bind flags, switchable keyboard layouts.                                                                                                       |
| `Basics/Autostart`                                | `exec-once` equivalent and startup ordering.                                                                                                                                                                    |
| `Advanced and Cool/Gestures`                      | `hl.gesture({ fingers, direction, action, ... })` syntax. Lists available directions and actions.                                                                                                              |
| `Advanced and Cool/Animations`                    | `hl.animation()`/`hl.curve()` syntax and the animation tree.                                                                                                                                                    |
| `Advanced and Cool/Expanding-functionality`       | **Lua scripting reference**: full `hl.on()` event table, convenience functions (`hl.get_*`), `hl.timer()`, dynamic config mutation, prop refresh. Read this when writing logic, not just static config.       |
| `Advanced and Cool/Using-hyprctl`                 | `hyprctl` commands: `eval`, `repl`, `dispatch`, `setprop`, `notify`, info commands, `monitors`/`clients`/`layers` dumps, flags. Essential for live probing.                                                    |
| `Advanced and Cool/Devices`                       | Per-device input config via `hl.device()`.                                                                                                                                                                      |
| `Advanced and Cool/Environment-variables`         | Environment variables for Hyprland and toolkits.                                                                                                                                                               |
| `Advanced and Cool/Multi-GPU`                     | Multi-GPU setup.                                                                                                                                                                                                |
| `Advanced and Cool/Permissions`                   | Permission control system via `hl.permission()`.                                                                                                                                                               |
| `Advanced and Cool/Performance`                   | Performance tuning tips.                                                                                                                                                                                        |
| `Advanced and Cool/Tearing`                       | Screen tearing configuration.                                                                                                                                                                                   |
| `Advanced and Cool/XWayland`                      | XWayland settings.                                                                                                                                                                                              |
| `Advanced and Cool/Uncommon-tips-and-tricks`      | Switchable layouts, per-monitor configs, etc. (no `&` in the filename).                                                                                                                                          |
| `Advanced and Cool/Notifications`                 | `hl.notification.create()` and the notification system.                                                                                                                                                         |
| `Advanced and Cool/Virtual-GPU`                  | Virtual GPU config.                                                                                                                                                                                            |
| `Layouts/Dwindle-Layout`                          | Dwindle layout options and dispatchers.                                                                                                                                                                        |
| `Layouts/Master-Layout`                           | Master layout options and dispatchers.                                                                                                                                                                          |
| `Layouts/Scrolling-Layout`                        | Scrolling layout options.                                                                                                                                                                                       |
| `Layouts/Monocle-Layout`                           | Monocle layout options.                                                                                                                                                                                         |
| `Layouts/Custom-Layouts`                          | Custom layouts via `hl.layout.register()`.                                                                                                                                                                     |

Other top-level wiki areas (`content/IPC`, `content/Nix`, `content/Nvidia`,
`content/Plugins`, `content/Useful Utilities`, `content/FAQ`) exist but are
rarely needed for config auditing; fetch them by full path if required.

### Example fetches

Verify a config variable (e.g. `misc.vrr`):

```
WebFetch https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/Configuring/Basics/Variables.md
```

Then search the output for the relevant `###` section (e.g. `### Misc`) and
find the option row in the table. Columns are: name, description, type,
default.

Verify a dispatcher:

```
WebFetch https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/Configuring/Basics/Dispatchers.md
```

Verify gesture / event / convenience function:

```
WebFetch https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/Configuring/Advanced%20and%20Cool/Gestures.md
WebFetch https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/Configuring/Advanced%20and%20Cool/Expanding-functionality.md
```

### If a fetch 404s

The wiki is reorganized from time to time. List the directory first to find
the real path:

```bash
curl -sL "https://api.github.com/repos/hyprwm/hyprland-wiki/contents/content/Configuring/<dir>"
```

(e.g. `Basics`, `Layouts`, `Advanced%20and%20Cool`, or top-level `Configuring`).
Each entry's `"name"` is the file inside that directory.

## Key things to know

### The Lua type stubs are the source of truth for the API

Hyprland ships autogenerated lua-language-server stubs describing the entire
`hl.*` API: every config-key alias, class (`HL.Monitor`, `HL.Window`,
`HL.Workspace`, `HL.LayerSurface`, `HL.Vec2`, ...), dispatcher, event name,
and convenience function. **Read the stubs before writing or debugging
geometry/field math** — they tell you which fields exist on each object and
their types.

Installed at (where `hyprland` is the derivation):

```
<nix store>/...-hyprland-<version>/share/hypr/stubs/hl.meta.lua
```

On a typical system `/usr/share/hypr/stubs/hl.meta.lua`. To locate it on
NixOS, inspect the Home Manager generation:

```bash
find /nix/store/*-home-manager-files/.config/hypr -name '.luarc.json' -exec cat {} \;
```

The `.luarc.json` `workspace.library` path points at the stubs directory.

### Live probing with hyprctl

`hl.*` runs inside the compositor. Use these read-only commands to verify
field names, types, and actual runtime values before writing math against
them (this is how you confirm whether a number is physical or logical pixels,
whether a field is `nil`, etc.):

```bash
hyprctl eval 'tostring(hl.get_active_monitor().width).."/"..tostring(hl.get_active_monitor().scale).."/"..tostring(hl.get_active_monitor().res)'
hyprctl repl            # interactive lua REPL against the live compositor
hyprctl -j monitors | python3 -m json.tool | head -60
hyprctl -j clients
hyprctl -j layers
```

`hyprctl eval '<lua>'` returns `ok` on success or the lua error string on
failure. A forced error is a convenient way to print a value:

```bash
hyprctl eval 'error("PROBE "..tostring(hl.get_active_monitor().reserved).."/"..tostring(hl.get_active_monitor().height))'
```

(Tip: `tostring(nil)` is `"nil"`, so this cleanly reveals missing fields.)

### Coordinate-system gotcha (common bug source)

Hyprland mixes physical and logical coordinate spaces. Getting this wrong
produces off-by-`scale` placement bugs (the classic "PiP is huge on the
scaled laptop screen but fine on the external monitor" symptom).

- `hyprctl -j monitors` `width`/`height`, and `HL.Monitor.width`/`height`,
  are **physical** pixels.
- Layout coordinates — `HL.Monitor.x`/`y`, `position` strings, and the
  `hl.dsp.window.move`/`resize` dispatchers — are **logical** (scaled)
  pixels. Per the Monitors page: positions are "calculated with the scaled
  (and transformed) resolution".
- `HL.Monitor.scale` is exposed; convert with
  `logical = physical / monitor.scale`.
- **Do all window-placement geometry math in one space** (logical is the
  safe default for move/resize dispatchers). The width/height you pass to
  `hl.dsp.window.resize({ x = w, y = h })` is logical; the `x`/`y` to
  `hl.dsp.window.move({ x, y, relative = false })` is logical.
- `HL.Monitor.reserved` is **not** exposed to lua (`nil` at runtime) — if you
  need insets (bars, reserved areas), derive them from `hl.get_layers()` by
  inspecting each `HL.LayerSurface`'s `x`/`y`/`w`/`h`/`mapped`/`namespace`,
  or skip the reserved area if the placement corner is unaffected.

### Core lua entry points

| Call                                   | Purpose                                                            |
| -------------------------------------- | ----------------------------------------------------------------- |
| `hl.config({ section = { opt = v } })` | set config options (merge; can be called repeatedly)              |
| `hl.monitor({ output, mode, ... })`   | configure a monitor                                               |
| `hl.window_rule({ match = {...}, ... })`   | declare a window rule (returns a handle with `set_enabled`)    |
| `hl.workspace_rule({ workspace, ... })`   | declare a workspace rule                                       |
| `hl.layer_rule({ match = {...}, ... })`   | declare a layer rule (returns a handle)                        |
| `hl.bind("mods+key", dispatcher_or_fn, opts?)` | register a keybind                                         |
| `hl.on("event.name", function(...) ...)`    | subscribe to an event (full list in Expanding-functionality)  |
| `hl.dispatch(dispatcher)`               | invoke a dispatcher returned by `hl.dsp.*`                        |
| `hl.dsp.<ns>.<method>({ ... })`         | build a dispatcher (window/workspace/group/cursor/...)            |
| `hl.gesture({ fingers, direction, action, ... })` | register a touchpad gesture                              |
| `hl.device({ name, ... })`              | per-device input config                                           |
| `hl.timer(fn, { timeout, type })`       | spawn a timer (handle has `set_enabled`/`is_enabled`)             |
| `hl.layout.register(name, provider)`    | register a custom layout                                          |
| `hl.notification.create({ text, timeout, icon? })` | show a notification                                      |

Convenience getters: `hl.get_active_window/monitor/workspace`,
`hl.get_windows/workspaces/monitors/layers`, `hl.get_window/monitor/workspace(selector)`,
`hl.get_urgent_window`, `hl.get_last_window/workspace`,
`hl.get_monitor_at({x,y})`, `hl.get_monitor_at_cursor()`, `hl.get_cursor_pos()`,
`hl.get_active_special_workspace()`, `hl.get_current_submap()`, `hl.version()`.

### Variables page structure

The Variables page is large (~36KB). Config sections are `### Heading` level
(e.g. `### General`, `### Decoration`, `### Input`, `### Misc`). Subcategories
use `#### Heading` with a note like `_Subcategory decoration:blur:_`. Each
section has a table of options with columns: name, description, type, default.

### Variable types

| Type        | Meaning                                                                 |
| ----------- | ----------------------------------------------------------------------- |
| `int`       | integer (not a string — don't quote it in Nix)                          |
| `bool`      | `true`/`false`                                                          |
| `float`     | floating point                                                          |
| `color`     | `"#rgb"/"#rrggbb"/"#rrggbbaa"`, `"rgba(...)"/"rgb(...)"`, or legacy `0xAARRGGBB` |
| `vec2`      | table `{ x, y }` (lua) / two floats separated by space (hyprlang)       |
| `str`       | a string                                                                |
| `gradient`  | a color, or `{ colors = {...}, angle? = n }`                            |
| `font_weight` | int 100–1000 or preset (`"thin"`, `"normal"`, `"bold"`, ...)           |
| `css_gaps`  | int, or `{ top?, left?, right?, bottom? }`                              |

### NixOS Home Manager considerations

When the config uses `configType = "lua"` (the modern default), set options
through `extraLuaFiles` as lua calling `hl.*` — Home Manager's
`wayland.windowManager.hyprland.settings` attrset (the old hyprlang mapping)
is **not** applied. Typed values in lua are just lua values (`true`/`false`,
numbers, strings, tables).

If a config still uses the legacy `settings` attrset:

- Integer options should be Nix integers (e.g. `vrr = 2;`), not strings
- Boolean options should be Nix booleans (`true`/`false`)
- String options should be Nix strings (`"value"`)
- The `gesture`, `bind`, `binde`, `bindm` keywords map to lists of strings

The `.luarc.json` shipped by Home Manager (when `configType = "lua"`) points
the lua-language-server at the stubs directory, giving type info and
autocompletion in editors that load it.