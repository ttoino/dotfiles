# Hyprland Cheat Sheet

**Main mod = <kbd>❖</kbd>** (Super). Config lives in `modules/hyprland/lua/` (Lua via
Home Manager's `hl.*` API): `00-options`, `01-animations`, `02-apps`, `03-keybinds`,
`04-rules`, `08-plugins` (+ host `05-monitors`, `06-cake`, `07-hyprlock-autostart`).
Launched through **UWSM**; `hyprland` is the default session on `bmo`. Apps run via
`uwsm-app` so each lands in its own systemd scope.

## Launchers & Apps

| Key                                                  | Action                        |
| ---------------------------------------------------- | ----------------------------- |
| <kbd>❖</kbd>&thinsp;<kbd>↵</kbd>                     | Terminal (kitty)              |
| <kbd>❖</kbd>&thinsp;<kbd>D</kbd>                     | App launcher (cake run menu)  |
| <kbd>❖</kbd>&thinsp;<kbd>B</kbd>                     | Browser (Firefox)             |
| <kbd>❖</kbd>&thinsp;<kbd>⇧</kbd>&thinsp;<kbd>B</kbd> | Secondary browser (Chromium)  |
| <kbd>❖</kbd>&thinsp;<kbd>E</kbd>                     | File explorer (yazi in kitty) |
| <kbd>❖</kbd>&thinsp;<kbd>⇧</kbd>&thinsp;<kbd>E</kbd> | Editor (nvim in kitty)        |
| <kbd>❖</kbd>&thinsp;<kbd>⇧</kbd>&thinsp;<kbd>D</kbd> | Discord (vesktop)             |
| <kbd>❖</kbd>&thinsp;<kbd>⎋</kbd>                     | Power / logout menu (cake)    |

## Screenshots & Color picker

| Key                                                  | Action                                        |
| ---------------------------------------------------- | --------------------------------------------- |
| <kbd>❖</kbd>&thinsp;<kbd>S</kbd>                     | Screenshot screen → clipboard (grimblast)     |
| <kbd>❖</kbd>&thinsp;<kbd>⇧</kbd>&thinsp;<kbd>S</kbd> | Screenshot region → clipboard                 |
| <kbd>❖</kbd>&thinsp;<kbd>⌃</kbd>&thinsp;<kbd>C</kbd> | Pick screen color → clipboard (hyprpicker -a) |

## Window management

| Key                                                  | Action                               |
| ---------------------------------------------------- | ------------------------------------ |
| <kbd>❖</kbd>&thinsp;<kbd>C</kbd>                     | Close window                         |
| <kbd>❖</kbd>&thinsp;<kbd>F</kbd>                     | Fullscreen                           |
| <kbd>❖</kbd>&thinsp;<kbd>M</kbd>                     | Maximize                             |
| <kbd>❖</kbd>&thinsp;<kbd>⇧</kbd>&thinsp;<kbd>F</kbd> | Toggle float                         |
| <kbd>❖</kbd>&thinsp;<kbd>P</kbd>                     | Pseudo (dwindle)                     |
| <kbd>❖</kbd>&thinsp;<kbd>J</kbd>                     | Toggle split (dwindle)               |
| <kbd>❖</kbd>&thinsp;<kbd>⇧</kbd>&thinsp;<kbd>P</kbd> | Pin window                           |
| <kbd>❖</kbd>&thinsp;<kbd>⇧</kbd>&thinsp;<kbd>V</kbd> | Toggle PiP (float + pin + tag `pip`) |

## Focus & Move

| Key                                                        | Action      |
| ---------------------------------------------------------- | ----------- |
| <kbd>❖</kbd>&thinsp;<kbd>←/→/↑/↓</kbd>                     | Move focus  |
| <kbd>❖</kbd>&thinsp;<kbd>⇧</kbd>&thinsp;<kbd>←/→/↑/↓</kbd> | Move window |

## Resize (repeating)

| Key                                                        | Action       |
| ---------------------------------------------------------- | ------------ |
| <kbd>❖</kbd>&thinsp;<kbd>⌃</kbd>&thinsp;<kbd>←/→/↑/↓</kbd> | Resize ±10px |

## Workspaces

| Key                                                               | Action                        |
| ----------------------------------------------------------------- | ----------------------------- |
| <kbd>❖</kbd>&thinsp;<kbd>1</kbd>–<kbd>0</kbd>                     | Focus workspace 1–10          |
| <kbd>❖</kbd>&thinsp;<kbd>⇧</kbd>&thinsp;<kbd>1</kbd>–<kbd>0</kbd> | Move window to workspace 1–10 |
| <kbd>❖</kbd>&thinsp;<kbd>scroll</kbd>                             | Cycle workspaces (e±1)        |

## Media

| Key                              | Action                 |
| -------------------------------- | ---------------------- |
| <kbd>❖</kbd>&thinsp;<kbd>.</kbd> | Next track (playerctl) |
| <kbd>❖</kbd>&thinsp;<kbd>,</kbd> | Previous track         |
| <kbd>❖</kbd>&thinsp;<kbd>␣</kbd> | Play / pause           |

## Special keys (work while locked)

| Key                                                                                     | Action             |
| --------------------------------------------------------------------------------------- | ------------------ |
| <kbd>&#x1F505;&#xFE0E;</kbd> / <kbd>&#x1F506;&#xFE0E;</kbd>                             | Brightness 10% −/+ |
| <kbd>&#x1F508;&#xFE0E;</kbd>                                                            | Toggle mute        |
| <kbd>&#x1F509;&#xFE0E;</kbd> / <kbd>&#x1F50A;&#xFE0E;</kbd>                             | Volume 5% −/+      |
| <kbd>&#x23EF;&#xFE0E;</kbd> / <kbd>&#x23EA;&#xFE0E;︎</kbd> / <kbd>&#x23E9;&#xFE0E;︎︎</kbd> | Media (playerctl)  |
| <kbd>&#x23FB;&#xFE0E;</kbd>                                                             | Power menu (cake)  |

## Mouse

| Key                                | Action        |
| ---------------------------------- | ------------- |
| <kbd>❖</kbd>&thinsp;<kbd>LMB</kbd> | Drag window   |
| <kbd>❖</kbd>&thinsp;<kbd>RMB</kbd> | Resize window |

## Gestures (3 fingers)

| Gesture          | Action           |
| ---------------- | ---------------- |
| Horizontal swipe | Switch workspace |
| Swipe down       | Close window     |
| Swipe up         | Fullscreen       |

## Layout & Look (options.lua)

- **Layout** — dwindle, `preserve_split`. Gaps in 8 / out 16. No borders (`border_size 0`). `allow_tearing` on.
- **Input** — `us,pt` layouts, **CapsLock toggles** between them (`grp:caps_toggle`). `follow_mouse 1`. Touchpad natural scroll off.
- **Decoration** — 16px rounding; active opacity 1, **inactive 0.75**; blur on (size 8, passes 3); native shadows off; dim inactive off.
- **Misc** — logo & splash off; background = catppuccin `surface0`; **VRR = 2** (fullscreen-only). `xwayland.force_zero_scaling`.

## Animations (animations.lua)

Material 3 "expressive" bezier curves. Windows `popin`, windowsOut `popin 80%`,
windowsMove `slide`, workspaces `slide`, layers `fade`, fade. Auto-animates on
monitor hotplug.

## Window rules (rules.lua)

- **Games** — `steam_app_*` and Minecraft → tagged `game`, `immediate` (bypass idle for tearing).
- **PiP** — Discord popout & "Picture-in-Picture" → tagged `pip`: float, pinned, opaque, no blur/dim, keep aspect. Auto-placed bottom-right at 25% of monitor (16:9, 16px margin).
- **Shimeji** — `oneko` → float, no focus/blur/shadow, no border.

## Plugins

- **shadows-plus-plus** — two-layer drop shadows (offset 0/4 + 0/8, blur 4 + 12) since native shadows are disabled.

## Companion services (fionna trait)

- **cake** — AGS shell: bar, app launcher (<kbd>❖</kbd>&thinsp;<kbd>D</kbd>), power menu (<kbd>❖</kbd>&thinsp;<kbd>⎋</kbd>). `cake-scrim` layer is blurred.
- **hyprlock** — locks on Hyprland start; background = blurred screenshot.
- **hypridle** — dim 2.5m → lock 5m → screen off 10m → suspend 30m.
- **hyprpaper** — wallpaper `outer-wilds-color.png`.
- **cliphist** — clipboard history (enabled).
- **hyprpolkitagent** — polkit agent (placeholder until cmd-polkit).

## Environment (uwsm env)

`NIXOS_OZONE_WL=1`, `ELECTRON_OZONE_PLATFORM_HINT=wayland`, `PROTON_ENABLE_HDR=1`,
`PROTON_ENABLE_WAYLAND=1`.

## Monitors (bmo)

- Laptop `eDP-2` auto-scales: **1.3333 solo**, **1 docked** (swaps on hotplug).
- Known externals (Samsung G5, LG Ultragear+) → preferred, `auto-left`, scale 1, 10-bit. Unknown monitors → preferred, scale 1.
