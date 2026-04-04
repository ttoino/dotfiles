# If in tty, don't use icons
if [[ $TTY == '/dev/tty'* ]]; then
    local BRACKET='%(#.».>)'
    local NIX='nix'
else
    local BRACKET='%(#.⟫.⟩)'
    local NIX='󱄅'
fi

# Add nix-shell info to right prompt
RPROMPT='${IN_NIX_SHELL:+ %F{cyan\}'$NIX' ${NIX_SHELL_PACKAGES:+ $NIX_SHELL_PACKAGES}%f}'

PROMPT=''

# Blue pwd
PROMPT+='%F{blue}%~ '

# Show '⟩' for normal users, '⟫' for root
# Show in green when last command was successful, red otherwise
SIMPLE_PROMPT='%(?.%F{green}.%F{red}%?)'$BRACKET' '
PROMPT+="$SIMPLE_PROMPT"

# Reset color
PROMPT+='%f'

# Simplify prompt after Enter
simplify-prompt-accept-line() {
    OLD_PROMPT="$PROMPT"
    OLD_RPROMPT="$RPROMPT"
    PROMPT="$SIMPLE_PROMPT"
    RPROMPT=""
    zle reset-prompt
    PROMPT="$OLD_PROMPT"
    RPROMPT="$OLD_RPROMPT"
    zle accept-line
}
zle -N simplify-prompt-accept-line
bindkey "^M" simplify-prompt-accept-line

# Add line before prompt
precmd() {
    precmd() {
        echo
    }
}

unset NIX BRACKET
