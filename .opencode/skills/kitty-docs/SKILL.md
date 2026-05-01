---
name: kitty-docs
description: Look up kitty terminal configuration options, keybindings, actions, and features from the official source. Use this skill whenever you need to verify or audit kitty config.
---

## When to use

Use this skill whenever you need to:

- Verify whether a kitty config option exists, its type, default, or valid values
- Check if an option has been deprecated or removed
- Look up keybinding syntax, mouse mappings, or actions
- Validate a `kitty.conf` or NixOS Home Manager kitty module for correctness
- Understand kitty features like shell integration, layouts, or remote control

## How to fetch documentation

Kitty's config documentation is split across two types of sources:

### 1. Authoritative option definitions (Python source)

The single source of truth for all config options is:

```
https://raw.githubusercontent.com/kovidgoyal/kitty/master/kitty/options/definition.py
```

This file defines every config option using `opt()` calls with name, default
value, type, valid choices, and documentation. It also lists all deprecated
options near the top via `definition.add_deprecation()` calls.

**WARNING:** This file is very large (~150KB). Use targeted searches rather
than reading it end-to-end. Search for the option name (e.g. `close_on_child_death`)
to find its definition quickly.

Key patterns to search for:

- `opt('option_name'` -- current option definition
- `add_deprecation(` -- deprecated options listed near top of file
- `choices=` -- valid values for enum-style options
- `option_type='to_bool'` -- boolean option (yes/no)

### 2. RST documentation files

The `docs/` directory contains `.rst` (reStructuredText) files for features,
protocols, and guides:

```
https://raw.githubusercontent.com/kovidgoyal/kitty/master/docs/{file}.rst
```

| File                    | What it covers                                                           |
| ----------------------- | ------------------------------------------------------------------------ |
| `conf.rst`              | Config file overview (includes generated `conf-kitty.rst` at build time) |
| `actions.rst`           | All mappable keyboard/mouse actions                                      |
| `mapping.rst`           | Keybind and mouse mapping syntax                                         |
| `layouts.rst`           | Window layout system (splits, tabs, stacks, etc.)                        |
| `remote-control.rst`    | Remote control protocol and `allow_remote_control` usage                 |
| `shell-integration.rst` | Shell integration features and configuration                             |
| `launch.rst`            | Launch command syntax for opening windows/tabs                           |
| `sessions.rst`          | Session file format                                                      |
| `faq.rst`               | Frequently asked questions                                               |
| `changelog.rst`         | Full changelog (very large ~213KB, search for specific versions)         |
| `overview.rst`          | Feature overview                                                         |
| `open_actions.rst`      | File/URL open actions                                                    |
| `kittens_intro.rst`     | Kittens (extensions) introduction                                        |
| `clipboard.rst`         | Clipboard protocol                                                       |
| `keyboard-protocol.rst` | Keyboard protocol                                                        |
| `graphics-protocol.rst` | Graphics/image protocol                                                  |

The `docs/kittens/` subdirectory has per-kitten docs (e.g. `ssh.rst`, `diff.rst`).

### Example fetches

To check if a config option exists and its valid values:

```
WebFetch https://raw.githubusercontent.com/kovidgoyal/kitty/master/kitty/options/definition.py
```

Then search the output for `opt('option_name'`.

To check the changelog for when an option was added/removed:

```
WebFetch https://raw.githubusercontent.com/kovidgoyal/kitty/master/docs/changelog.rst
```

Then search for the option name.

## Key things to know

### Config format

Kitty uses **flat key-value pairs**, not dotted/nested notation:

```ini
# Correct
close_on_child_death no
allow_remote_control socket-only

# WRONG -- kitty does NOT support dotted notation
shell.close_on_child_death no
```

### NixOS Home Manager considerations

When using `programs.kitty.settings` in Home Manager:

- All keys are flat strings (no dots): `"close_on_child_death" = "no";`
- Values are always strings in the attrset: `"font_size" = "12.0";`
- Home Manager converts the attrset to kitty's `key value` format
- Boolean options use `"yes"`/`"no"` strings, not Nix booleans
- For keybindings, use `programs.kitty.keybindings` instead of `settings`
