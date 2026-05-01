---
name: zsh-docs
description: Look up Zsh configuration options, builtins, parameters, and features from the official documentation source. Use this skill whenever you need to verify or audit zsh configuration.
---

## When to use

Use this skill whenever you need to:

- Verify Zsh options (setopt/unsetopt) and their behavior
- Check builtin commands and their arguments
- Look up parameter expansion syntax and modifiers
- Understand completion system (compsys) configuration
- Verify ZLE (Zsh Line Editor) widgets and keymaps
- Check conditional expressions and globbing patterns
- Validate zsh syntax in NixOS Home Manager or standalone configs

## How to fetch documentation

The authoritative source is the raw yodl documentation in the zsh-users/zsh GitHub repo under `Doc/Zsh/`.

### Base URL

```
https://raw.githubusercontent.com/zsh-users/zsh/master/Doc/Zsh/{file}.yo
```

### Available documentation files

| File              | What it covers                                                                                                                                                                                   |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `options.yo`      | All shell options (setopt/unsetopt), organized by category: Changing Directories, Completion, Expansion and Globbing, History, Input/Output, Job Control, Prompting, Scripts and Functions, etc. |
| `builtins.yo`     | All builtin commands (cd, echo, set, typeset, autoload, etc.) with full syntax and descriptions                                                                                                  |
| `expn.yo`         | Parameter expansion, command substitution, arithmetic expansion, brace expansion, filename generation                                                                                            |
| `params.yo`       | Shell parameters (variables), special parameters ($@, $#, etc.), and parameter attributes                                                                                                        |
| `zle.yo`          | Zsh Line Editor - widgets, keymaps, special variables like $KEYMAP, $ZLE_STATE                                                                                                                   |
| `compsys.yo`      | Completion system configuration, styles, functions, and completers                                                                                                                               |
| `compwid.yo`      | Completion widgets and low-level completion functions                                                                                                                                            |
| `cond.yo`         | Conditional expressions ([[...]]), test operators                                                                                                                                                |
| `grammar.yo`      | Shell grammar, pipelines, lists, redirections                                                                                                                                                    |
| `mod_complist.yo` | The zsh/complist module (menu selection)                                                                                                                                                         |
| `mod_computil.yo` | The zsh/computil module (completion utilities)                                                                                                                                                   |
| `mod_zutil.yo`    | The zsh/zutil module (utility functions)                                                                                                                                                         |
| `mod_curses.yo`   | The zsh/curses module (curses bindings)                                                                                                                                                          |
| `mod_termcap.yo`  | The zsh/termcap module (terminal capabilities)                                                                                                                                                   |
| `mod_terminfo.yo` | The zsh/terminfo module (terminfo access)                                                                                                                                                        |
| `mod_regex.yo`    | The zsh/regex module (PCRE regular expressions)                                                                                                                                                  |
| `mod_zselect.yo`  | The zsh/zselect module (file descriptor multiplexing)                                                                                                                                            |
| `mod_zpty.yo`     | The zsh/zpty module (pseudo-terminals)                                                                                                                                                           |
| `mod_socket.yo`   | The zsh/socket module (TCP/UDP sockets)                                                                                                                                                          |
| `mod_system.yo`   | The zsh/system module (system calls)                                                                                                                                                             |
| `mod_datetime.yo` | The zsh/datetime module (time and date)                                                                                                                                                          |
| `mod_math.yo`     | The zsh/math module (mathematical functions)                                                                                                                                                     |

### Example fetches

To check an option like `AUTO_CD`:

```
WebFetch https://raw.githubusercontent.com/zsh-users/zsh/master/Doc/Zsh/options.yo
```

Then search for `pindex(AUTO_CD)` or `item(tt(AUTO_CD)`.

To check a builtin like `typeset`:

```
WebFetch https://raw.githubusercontent.com/zsh-users/zsh/master/Doc/Zsh/builtins.yo
```

Then search for `findex(typeset)`.

To check parameter expansion modifiers:

```
WebFetch https://raw.githubusercontent.com/zsh-users/zsh/master/Doc/Zsh/expn.yo
```

Then search for `subsect(Modifiers)` or specific patterns like `${var:s/old/new}`.

## Key things to know

### Documentation format (yodl)

The yodl format uses these markup patterns:

- `pindex(NAME)` - Index entry for an option/parameter
- `findex(NAME)` - Index entry for a function/builtin
- `item(tt(NAME))` - Definition of an option/command
- `sect(Title)` - Section heading
- `subsect(Title)` - Subsection heading
- `tt(text)` - Typewriter text (code/command)
- `var(name)` - Variable/metavariable
- `bf(text)` - Bold text
- `em(text)` - Emphasized text
- `example(...)` - Code example

### Option documentation pattern

Options are documented like this:

```
pindex(AUTO_CD)
pindex(NO_AUTO_CD)
item(tt(AUTO_CD) (tt(-J)))(
Description of the option...
)
```

Options often have multiple index entries:

- `pindex(OPTION_NAME)` - the positive form
- `pindex(NO_OPTION_NAME)` - the negative form
- Short form like `pindex(AUTOCD)` - alternative spelling (no underscore)

### Zsh option types

Options marked with:

- `<D>` - Set by default in zsh emulation
- `<C>` - Set by default in csh emulation
- `<K>` - Set by default in ksh emulation
- `<S>` - Set by default in sh emulation
- `<Z>` - Set by default in zsh emulation

### Completion system (compsys)

The completion system is complex and involves:

- `zstyle` configurations for completion behavior
- Completer functions (\_complete, \_approximate, \_correct, etc.)
- Style settings like `menu select`, `list-colors`, etc.

Key files for completion:

- `compsys.yo` - Overview and configuration
- `compwid.yo` - Completion widgets
- `mod_complist.yo` - Menu selection

### NixOS Home Manager considerations

When configuring zsh via Home Manager:

```nix
programs.zsh = {
  enable = true;

  # Options use setopt/unsetopt
  # In Nix, use boolean-like settings in initExtra:
  initExtra = ''
    setopt AUTO_CD
    setopt AUTO_PUSHD
    unsetopt BEEP
  '';

  # Or use the options attrset (if available in your HM version):
  # options = {
  #   AUTO_CD = true;
  #   BEEP = false;
  # };

  # Plugins can use oh-my-zsh, prezto, or manual loading
  plugins = [
    {
      name = "plugin-name";
      src = pkgs.fetchFromGitHub { ... };
    }
  ];
};
```

### Common option categories

**Changing Directories:**

- `AUTO_CD`, `AUTO_PUSHD`, `PUSHD_SILENT`, `CDABLE_VARS`, `CHASE_LINKS`

**Completion:**

- `ALWAYS_LAST_PROMPT`, `AUTO_LIST`, `AUTO_MENU`, `MENU_COMPLETE`, `GLOB_COMPLETE`

**Expansion and Globbing:**

- `GLOB`, `EXTENDED_GLOB`, `GLOB_DOTS`, `NULL_GLOB`, `NOMATCH`, `RC_EXPAND_PARAM`

**History:**

- `APPEND_HISTORY`, `EXTENDED_HISTORY`, `HIST_IGNORE_DUPS`, `HIST_IGNORE_SPACE`, `SHARE_HISTORY`

**Input/Output:**

- `CLOBBER`, `CORRECT`, `IGNORE_EOF`, `INTERACTIVE_COMMENTS`, `HASH_CMDS`

**Scripts and Functions:**

- `LOCAL_OPTIONS`, `LOCAL_TRAPS`, `FUNCTION_ARGZERO`, `WARN_CREATE_GLOBAL`

### Parameter expansion modifiers

Common modifiers (in `expn.yo`):

- `${var:h}` - head (dirname)
- `${var:t}` - tail (basename)
- `${var:r}` - remove extension
- `${var:e}` - extension only
- `${var:l}` - lowercase
- `${var:u}` - uppercase
- `${var:s/old/new}` - substitute
- `${var//old/new}` - substitute all

### Important notes

1. **Options vs Parameters**: Options (setopt) are different from parameters (variables). Options control shell behavior, parameters store data.

2. **Emulation modes**: Zsh can emulate sh, ksh, or csh with `emulate sh`, `emulate ksh`, etc. This affects default options.

3. **Completion is complex**: The new completion system (compsys) is very powerful but requires understanding of styles, contexts, and completers. The old system (compctl) is deprecated.

4. **ZLE widgets**: Custom widgets must call `zle -N widgetname function` and can use `zle` builtin to invoke other widgets.

5. **Globbing flags**: Zsh has extensive globbing features like `(#q.)` for qualifiers, `(#i)` for case-insensitive matching.
