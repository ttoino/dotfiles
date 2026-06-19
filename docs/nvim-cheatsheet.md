# nvf Cheat Sheet

**Leader = <kbd>␣</kbd>** (explicitly set). Press <kbd>␣</kbd> and wait 1s → which-key shows all <kbd>␣</kbd> bindings.
`vim` launches the config; `EDITOR=nvim` is set system-wide.

## Files & Picker (snacks.picker)

| Key | Action |
| --- | --- |
| <kbd>␣</kbd>&thinsp;<kbd>␣</kbd> | Smart find files |
| <kbd>␣</kbd>&thinsp;<kbd>f</kbd>&thinsp;<kbd>f</kbd> | Find files |
| <kbd>␣</kbd>&thinsp;<kbd>f</kbd>&thinsp;<kbd>g</kbd> | Find git-tracked files |
| <kbd>␣</kbd>&thinsp;<kbd>f</kbd>&thinsp;<kbd>r</kbd> | Recent files |
| <kbd>␣</kbd>&thinsp;<kbd>,</kbd> | Switch buffer |
| <kbd>␣</kbd>&thinsp;<kbd>e</kbd> | File explorer (toggle) |
| <kbd>␣</kbd>&thinsp;<kbd>:</kbd> | Command history |
| <kbd>␣</kbd>&thinsp;<kbd>/</kbd> | Live grep |
| <kbd>␣</kbd>&thinsp;<kbd>s</kbd>&thinsp;<kbd>w</kbd> | Grep word / visual selection (n + x) |
| <kbd>␣</kbd>&thinsp;<kbd>s</kbd>&thinsp;<kbd>b</kbd> | Search lines in current buffer |

Inside any picker: <kbd>⌃s</kbd> split, <kbd>⌃v</kbd> vsplit, <kbd>⌃t</kbd> tab, <kbd>⎋</kbd> close, <kbd>↵</kbd> open.

## LSP (nvf defaults — <kbd>␣</kbd>&thinsp;<kbd>l</kbd>&thinsp;<kbd>*</kbd>)

| Key | Action |
| --- | --- |
| <kbd>g</kbd>&thinsp;<kbd>d</kbd> / <kbd>g</kbd>&thinsp;<kbd>D</kbd> | Go to definition / declaration |
| <kbd>g</kbd>&thinsp;<kbd>i</kbd> | Go to implementation |
| <kbd>g</kbd>&thinsp;<kbd>y</kbd> | Go to type definition |
| <kbd>g</kbd>&thinsp;<kbd>r</kbd> | References |
| <kbd>K</kbd> | Hover doc |
| <kbd>⌃k</kbd> | Signature help |
| <kbd>␣</kbd>&thinsp;<kbd>l</kbd>&thinsp;<kbd>a</kbd> | Code action |
| <kbd>␣</kbd>&thinsp;<kbd>l</kbd>&thinsp;<kbd>r</kbd> | Rename symbol |
| <kbd>␣</kbd>&thinsp;<kbd>l</kbd>&thinsp;<kbd>f</kbd> | Format buffer (also auto-formats on save) |
| <kbd>␣</kbd>&thinsp;<kbd>l</kbd>&thinsp;<kbd>h</kbd> | Hover |
| <kbd>␣</kbd>&thinsp;<kbd>l</kbd>&thinsp;<kbd>S</kbd> | Document symbols |
| <kbd>␣</kbd>&thinsp;<kbd>l</kbd>&thinsp;<kbd>w</kbd>&thinsp;<kbd>s</kbd> | Workspace symbols |
| <kbd>␣</kbd>&thinsp;<kbd>l</kbd>&thinsp;<kbd>e</kbd> | Show line diagnostics (float) |
| <kbd>␣</kbd>&thinsp;<kbd>l</kbd>&thinsp;<kbd>n</kbd> / <kbd>␣</kbd>&thinsp;<kbd>l</kbd>&thinsp;<kbd>p</kbd> | Next / prev diagnostic |
| <kbd>␣</kbd>&thinsp;<kbd>l</kbd>&thinsp;<kbd>t</kbd>&thinsp;<kbd>f</kbd> | Toggle format-on-save |

## LSP via snacks pickers

| Key | Action |
| --- | --- |
| <kbd>␣</kbd>&thinsp;<kbd>s</kbd>&thinsp;<kbd>s</kbd> | LSP symbols (current buffer) |
| <kbd>␣</kbd>&thinsp;<kbd>s</kbd>&thinsp;<kbd>S</kbd> | LSP workspace symbols |

## Diagnostics (trouble.nvim)

| Key | Action |
| --- | --- |
| <kbd>␣</kbd>&thinsp;<kbd>l</kbd>&thinsp;<kbd>d</kbd> | Document diagnostics |
| <kbd>␣</kbd>&thinsp;<kbd>l</kbd>&thinsp;<kbd>w</kbd>&thinsp;<kbd>d</kbd> | Workspace diagnostics |
| <kbd>␣</kbd>&thinsp;<kbd>l</kbd>&thinsp;<kbd>r</kbd> | LSP references |
| <kbd>␣</kbd>&thinsp;<kbd>x</kbd>&thinsp;<kbd>q</kbd> | Quickfix list |
| <kbd>␣</kbd>&thinsp;<kbd>x</kbd>&thinsp;<kbd>l</kbd> | Location list |
| <kbd>␣</kbd>&thinsp;<kbd>x</kbd>&thinsp;<kbd>s</kbd> | Symbols |

## Git

| Key | Action |
| --- | --- |
| <kbd>␣</kbd>&thinsp;<kbd>g</kbd>&thinsp;<kbd>b</kbd> | Branches |
| <kbd>␣</kbd>&thinsp;<kbd>g</kbd>&thinsp;<kbd>l</kbd> | Log (repo) |
| <kbd>␣</kbd>&thinsp;<kbd>g</kbd>&thinsp;<kbd>f</kbd> | Log (current file) |
| <kbd>␣</kbd>&thinsp;<kbd>g</kbd>&thinsp;<kbd>s</kbd> | Git status |
| <kbd>␣</kbd>&thinsp;<kbd>g</kbd>&thinsp;<kbd>d</kbd> | Diff (hunks) |
| <kbd>␣</kbd>&thinsp;<kbd>g</kbd>&thinsp;<kbd>B</kbd> | Open file/line in browser (gitbrowse) — n + x |

Gitsigns (hunks, <kbd>␣</kbd>&thinsp;<kbd>h</kbd>&thinsp;<kbd>*</kbd>):

| Key | Action |
| --- | --- |
| <kbd>]</kbd>&thinsp;<kbd>c</kbd> / <kbd>[</kbd>&thinsp;<kbd>c</kbd> | Next / prev hunk |
| <kbd>␣</kbd>&thinsp;<kbd>h</kbd>&thinsp;<kbd>s</kbd> | Stage hunk |
| <kbd>␣</kbd>&thinsp;<kbd>h</kbd>&thinsp;<kbd>r</kbd> | Reset hunk |
| <kbd>␣</kbd>&thinsp;<kbd>h</kbd>&thinsp;<kbd>R</kbd> | Reset buffer |
| <kbd>␣</kbd>&thinsp;<kbd>h</kbd>&thinsp;<kbd>p</kbd> | Preview hunk |
| <kbd>␣</kbd>&thinsp;<kbd>h</kbd>&thinsp;<kbd>b</kbd> | Blame line |
| <kbd>␣</kbd>&thinsp;<kbd>h</kbd>&thinsp;<kbd>D</kbd> | Diff this ~ file |
| <kbd>␣</kbd>&thinsp;<kbd>t</kbd>&thinsp;<kbd>d</kbd> | Toggle deleted |

## GitHub (snacks.gh — needs `gh auth login`)

| Key | Action |
| --- | --- |
| <kbd>␣</kbd>&thinsp;<kbd>g</kbd>&thinsp;<kbd>i</kbd> | Open issues |
| <kbd>␣</kbd>&thinsp;<kbd>g</kbd>&thinsp;<kbd>p</kbd> | Open pull requests |

In a GitHub buffer: <kbd>↵</kbd> actions menu, <kbd>i</kbd> edit, <kbd>a</kbd> comment, <kbd>c</kbd> close, <kbd>o</kbd> reopen.

## Completion (blink-cmp)

| Key | Action |
| --- | --- |
| <kbd>⌃␣</kbd> | Trigger completion |
| <kbd>⇥</kbd> / <kbd>⇧⇥</kbd> | Next / prev item |
| <kbd>↵</kbd> | Confirm |
| <kbd>⌃e</kbd> | Close |
| <kbd>⌃f</kbd> / <kbd>⌃d</kbd> | Scroll docs down / up |

Signature help shows automatically (blink's builtin signature feature).

## Toggles (snacks.toggle — <kbd>␣</kbd>&thinsp;<kbd>u</kbd>&thinsp;<kbd>*</kbd>)

| Key | Action |
| --- | --- |
| <kbd>␣</kbd>&thinsp;<kbd>u</kbd>&thinsp;<kbd>s</kbd> | Toggle spell check |
| <kbd>␣</kbd>&thinsp;<kbd>u</kbd>&thinsp;<kbd>w</kbd> | Toggle wrap |
| <kbd>␣</kbd>&thinsp;<kbd>u</kbd>&thinsp;<kbd>L</kbd> | Toggle relative line numbers |
| <kbd>␣</kbd>&thinsp;<kbd>u</kbd>&thinsp;<kbd>l</kbd> | Toggle line numbers |
| <kbd>␣</kbd>&thinsp;<kbd>u</kbd>&thinsp;<kbd>d</kbd> | Toggle diagnostics |
| <kbd>␣</kbd>&thinsp;<kbd>u</kbd>&thinsp;<kbd>c</kbd> | Toggle conceal level |
| <kbd>␣</kbd>&thinsp;<kbd>u</kbd>&thinsp;<kbd>T</kbd> | Toggle treesitter highlighting |
| <kbd>␣</kbd>&thinsp;<kbd>u</kbd>&thinsp;<kbd>b</kbd> | Toggle dark/light background |
| <kbd>␣</kbd>&thinsp;<kbd>u</kbd>&thinsp;<kbd>h</kbd> | Toggle inlay hints |
| <kbd>␣</kbd>&thinsp;<kbd>u</kbd>&thinsp;<kbd>g</kbd> | Toggle indent guides |

## Comments (comment-nvim)

| Key | Action |
| --- | --- |
| <kbd>g</kbd>&thinsp;<kbd>c</kbd>&thinsp;<kbd>c</kbd> | Toggle current line |
| <kbd>g</kbd>&thinsp;<kbd>c</kbd>&thinsp;<kbd>{motion}</kbd> | Toggle via motion (e.g. <kbd>g</kbd>&thinsp;<kbd>c</kbd>&thinsp;<kbd>a</kbd>&thinsp;<kbd>p</kbd> = paragraph) |
| <kbd>g</kbd>&thinsp;<kbd>c</kbd> (visual) | Toggle selection |

## Editing

- **Autopairs** — auto-closes `()`, `[]`, `{}`, quotes.
- **Words (LSP references)** — <kbd>]</kbd>&thinsp;<kbd>]</kbd> / <kbd>[</kbd>&thinsp;<kbd>[</kbd> jump to next/prev reference (n + terminal).
- **Spellcheck** — `en` + `pt`. <kbd>]</kbd>&thinsp;<kbd>s</kbd> / <kbd>[</kbd>&thinsp;<kbd>s</kbd> next/prev misspelling, <kbd>z</kbd>&thinsp;<kbd>=</kbd> suggestions, <kbd>z</kbd>&thinsp;<kbd>g</kbd> add word.

## Snacks QoL (enabled, no keymap needed)

- **dashboard** — greeter on empty start (pick recent file / project / new)
- **notifier** — pretty `vim.notify` (replaces noice)
- **statuscolumn** — gitsigns + diagnostics marks in the sign column
- **indent** — indent guides + scope (replaces indent-blankline)
- **bigfile / quickfile** — fast handling of huge files
- **scope** — treesitter/indent scope detection
- **scroll** — smooth scrolling
- **input** — nicer `vim.ui.input` (rename, etc.)
- **image** — renders images & PDFs inline in markdown/html (kitty graphics protocol). `:checkhealth snacks` to verify.
- **gitbrowse** — <kbd>␣</kbd>&thinsp;<kbd>g</kbd>&thinsp;<kbd>B</kbd> (above)

## Languages (auto LSP + format-on-save + treesitter + extra diagnostics)

| Lang | LSP | Formatter |
| --- | --- | --- |
| Nix | nil | nixfmt |
| TS/JS | typescript-language-server | prettierd (+ ts-error-translator) |
| Python | basedpyright + ruff | ruff |
| Rust | rust-analyzer (rustaceanvim) + crates-nvim | rustfmt |
| C/C++ | clangd | clang-format |
| Lua | lua-language-server | stylua |
| Bash | bash-language-server | shfmt |
| HTML/CSS/Svelte | built-in LSPs | — |
| Docker/YAML/TOML/Typst/Markdown | built-in LSPs | — |

## Useful `:` commands

| Command | Action |
| --- | --- |
| `:checkhealth snacks` | Verify snacks setup (image terminal support etc.) |
| `:Snacks` | Explore snacks API |
| `:LspInfo` | LSP status for current buffer |
| `:Trouble` | Open trouble panel manually |
| `:Mason` | (not installed — LSPs are managed by Nix) |
| `:h nvf` | nvf help (if manpages enabled) |

## First-time setup

1. `gh auth login` once (for <kbd>␣</kbd>&thinsp;<kbd>g</kbd>&thinsp;<kbd>i</kbd> / <kbd>␣</kbd>&thinsp;<kbd>g</kbd>&thinsp;<kbd>p</kbd>)
2. Open a Nix file → <kbd>g</kbd>&thinsp;<kbd>d</kbd> should jump via nil; save → nixfmt runs
3. `:checkhealth snacks` → confirm `image` says your kitty supports the graphics protocol
