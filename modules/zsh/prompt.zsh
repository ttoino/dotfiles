# Add nix-shell info to right prompt
RPROMPT='${IN_NIX_SHELL:+ %F{cyan\}󱄅 ${NIX_SHELL_PACKAGES:+ $NIX_SHELL_PACKAGES}%f}'

# Add gitstatus to right prompt
GITSTATUS='GITSTATUS_PROMPT'
# Remove first color code
GITSTATUS='${'$GITSTATUS'#\%76F}'
# Replace hardcoded colors with zsh color codes
GITSTATUS='${'$GITSTATUS'//\%76F/%F{green\}}'
GITSTATUS='${'$GITSTATUS'//\%178F/%F{yellow\}}'
GITSTATUS='${'$GITSTATUS'//\%39F/%F{blue\}}'
GITSTATUS='${'$GITSTATUS'//\%196F/%F{red\}}'
RPROMPT+='${GITSTATUS_PROMPT:+ %F{magenta\}󰘬  '$GITSTATUS'}'

PROMPT=''

# Blue pwd
PROMPT+='%F{blue}%~ '

# Show '⟩' for normal users, '⟫' for root
# Show in green when last command was successful, red otherwise
SIMPLE_PROMPT='%(?.%F{green}.%F{red}%?)%(#.⟫.⟩) '
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
