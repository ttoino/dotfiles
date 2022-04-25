alias reload_prompt="source $ZDOTDIR/prompt.zsh"

# Add gitstatus to right prompt
zsh_add_plugin "romkatv/gitstatus" "gitstatus.prompt"
RPROMPT='$GITSTATUS_PROMPT'
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
