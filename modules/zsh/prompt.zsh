# If in tty, don't use icons
if [[ $TTY == '/dev/tty'* ]]; then
    local BRACKET='%(#.».>)'
    local CLOCK='t'
    local NIX='nix'
else
    local BRACKET='%(#.⟫.⟩)'
    local CLOCK=' '
    local NIX='󱄅 '
fi

PROMPT=''
RPROMPT=''

# Blue pwd
PROMPT+='%F{blue}%~ '

# Show '⟩' for normal users, '⟫' for root
# Show in green when last command was successful, red otherwise
SIMPLE_PROMPT='%(?.%F{green}.%F{red}%?)'$BRACKET' '
PROMPT+="$SIMPLE_PROMPT"

# Orange command duration
RPROMPT+='${LAST_CMD_DURATION:+ %F{red\}'$CLOCK' $LAST_CMD_DURATION}'

# Cyan Nix info
RPROMPT+='${IN_NIX_SHELL:+ %F{cyan\}'$NIX'${NIX_SHELL_PACKAGES:+ $NIX_SHELL_PACKAGES}}'

# Reset color
PROMPT+='%f'
RPROMPT+='%f'

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
# Track command execution time and display if > 10s
local _prompt_first=1

precmd() {
    if [[ -n "$ZSH_CMD_START_TIME" ]]; then
        local duration=$(( EPOCHSECONDS - ZSH_CMD_START_TIME ))
        if (( duration > 10 )); then
            LAST_CMD_DURATION="${duration}s"
        else
            LAST_CMD_DURATION=""
        fi
        unset ZSH_CMD_START_TIME
    else
        LAST_CMD_DURATION=""
    fi

    (( _prompt_first )) && _prompt_first=0 || echo
}

preexec() {
    ZSH_CMD_START_TIME=$EPOCHSECONDS
}

unset NIX BRACKET
